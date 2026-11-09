#!/usr/bin/env bash
# Git config + personal/work GitHub accounts (docs/github-accounts.md).
#
#   ./install.sh git           set up (prompts when run in a terminal), then check
#   ./install.sh git --check   only check: identity, ssh auth and gh per account
set -euo pipefail
source "$REPO/install/lib.sh"

PERSONAL_USER=garbray
local_work="$HOME/.config/git/work.gitconfig"
localenv="$HOME/.localenv"

work_user() { sed -n 's/^export GH_WORK_USER=//p' "$localenv" 2>/dev/null | tail -1; }

# ensure_key <personal|work> <github user>
# ~/.ssh/github_<account>: link an existing key or generate one, then make sure
# its public half is on that GitHub account.
ensure_key() {
    local acct=$1 user=$2 key="$HOME/.ssh/github_$1" src="" token pub ans=y
    mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
    if [[ ! -e "$key" ]]; then
        if [[ ! -t 0 ]]; then
            warn "no $key: run ./install.sh git in a terminal"
            return 0
        fi
        log "ssh key for $acct${user:+ ($user)} -> $key"
        find "$HOME/.ssh" -maxdepth 1 -name '*.pub' ! -name 'github_*' | sed 's/\.pub$//; s|^|  |'
        read -rp "existing $acct private key to reuse (blank = generate new): " src
        if [[ -n "$src" ]]; then
            src="${src/#\~/$HOME}"
            if [[ ! -f "$src" || ! -f "$src.pub" ]]; then
                warn "$src or $src.pub not found; skipped $acct key"
                return 0
            fi
            ln -s "$src" "$key"
            ln -s "$src.pub" "$key.pub"
            log "linked $key -> $src"
        else
            ssh-keygen -t ed25519 -C "github_$acct $(hostname -s)" -f "$key"
        fi
    fi

    [[ -n "$user" ]] || return 0
    if ! token="$(gh auth token --user "$user" 2>/dev/null)"; then
        warn "gh not logged in as $user; can't check $key.pub on GitHub"
        return 0
    fi
    pub="$(awk '{print $2}' "$key.pub")"
    GH_TOKEN=$token gh api user/keys -q '.[].key' 2>/dev/null | grep -qF "$pub" && return 0
    if [[ -t 0 ]]; then
        read -rp "add $key.pub to GitHub user $user? [Y/n] " ans
    else
        ans=n
    fi
    if [[ "$ans" != [nN]* ]]; then
        GH_TOKEN=$token gh ssh-key add "$key.pub" --title "$(hostname -s) github_$acct" ||
            warn "upload failed (key already on another account?)"
    else
        warn "$key.pub is not on GitHub user $user"
    fi
}

setup() {
    log "configuring git"
    git config --global core.editor "nvim"
    git config --global rebase.updateRefs true

    # identity per directory: personal by default, work under ~/workspace/work/.
    # name/email live in the included files.
    git config --global --unset user.email || true
    git config --global --unset user.name || true
    # literal ~ on purpose: git expands it, so ~/.gitconfig stays portable
    # shellcheck disable=SC2088
    git config --global include.path "~/.config/git-accounts/personal.gitconfig"
    # shellcheck disable=SC2088
    git config --global "includeIf.gitdir:~/workspace/work/.path" "~/.config/git-accounts/work.gitconfig"

    # machine-local work email, kept out of this public repo
    if [[ ! -e "$local_work" ]]; then
        mkdir -p "$(dirname "$local_work")"
        email=""
        [[ -t 0 ]] && read -rp "work git email (blank to skip): " email
        if [[ -n "$email" ]]; then
            printf '[user]\n\temail = %s\n' "$email" >"$local_work"
            log "wrote $local_work"
        else
            warn "no work email: create $local_work (docs/github-accounts.md)"
        fi
    fi
    # the key path is standard now and set in the repo's work.gitconfig
    if git config -f "$local_work" core.sshCommand >/dev/null 2>&1; then
        git config -f "$local_work" --unset core.sshCommand
        log "dropped core.sshCommand from $local_work (now ~/.ssh/github_work)"
    fi

    # work github user for the ghAccount zsh hook, machine-local
    touch "$localenv"
    if [[ -z "$(work_user)" ]]; then
        user=""
        [[ -t 0 ]] && read -rp "work github username (blank to skip): " user
        if [[ -n "$user" ]]; then
            printf '\nexport GH_WORK_USER=%s\n' "$user" >>"$localenv"
            log "added GH_WORK_USER to $localenv"
        else
            warn "set GH_WORK_USER in $localenv for the gh account hook"
        fi
    fi

    # both accounts logged in to gh (keyring); login is interactive, so tty only
    for user in "$PERSONAL_USER" $(work_user); do
        gh auth token --user "$user" >/dev/null 2>&1 && continue
        if [[ -t 0 ]]; then
            log "gh login for $user (pick that account in the browser)"
            gh auth login --hostname github.com --git-protocol ssh --web || warn "gh login for $user failed"
        else
            warn "gh not logged in as $user: run gh auth login"
        fi
    done

    ensure_key personal "$PERSONAL_USER"
    ensure_key work "$(work_user)"

    # old hosts.yml-copy aliases broke multi-account gh; ghAccount replaces them
    for a in personal work; do
        gh alias list 2>/dev/null | grep -q "^$a:" && gh alias delete "$a" >/dev/null
    done
    # ...and their snapshots hold plain-text tokens
    for f in "$HOME"/.config/gh/hosts.yml.{personal,work}; do
        [[ -e "$f" ]] || continue
        ans=n
        [[ -t 0 ]] && read -rp "delete old token snapshot $f? [y/N] " ans
        if [[ "$ans" == [yY]* ]]; then
            rm "$f"
            warn "deleted $f; revoke its token at https://github.com/settings/applications"
        else
            warn "$f holds a plain-text token: delete it and revoke the token"
        fi
    done
    true
}

fails=0
ok() { printf "  \033[32m✓\033[0m %s\n" "$*"; }
bad() { printf "  \033[31m✗\033[0m %s\n" "$*"; fails=$((fails + 1)); }

# check_account <label> <dir under which a repo gets this account> <github user>
check_account() {
    local label=$1 parent=$2 want=$3 tmp email ssh_cmd key got token
    log "$label (expect github user: ${want:-?})"
    mkdir -p "$parent"
    tmp="$(mktemp -d "$parent/.git-accounts-check.XXXXXX")"
    git init -q "$tmp"
    email="$(git -C "$tmp" config user.email || true)"
    ssh_cmd="$(git -C "$tmp" config core.sshCommand || true)"
    rm -rf "$tmp"

    [[ -n "$email" ]] && ok "commit email: $email" || bad "no commit email"
    key="$(sed -n 's/.*-i \([^ ]*\).*/\1/p' <<<"$ssh_cmd")"
    key="${key/#\~/$HOME}"
    if [[ -z "$key" ]]; then
        bad "no ssh key in core.sshCommand"
    elif [[ ! -e "$key" ]]; then
        bad "ssh key $key does not exist"
    else
        # GitHub answers "Hi <user>!" for the first key it accepts
        got="$(eval "$ssh_cmd -o BatchMode=yes -T git@github.com" 2>&1 | sed -n 's/^Hi \([^!]*\)!.*/\1/p' || true)"
        if [[ -n "$want" && "$got" == "$want" ]]; then
            ok "ssh key $key -> $got"
        else
            bad "ssh key $key authenticates as '${got:-nothing}', want '$want'"
        fi
    fi

    if [[ -z "$want" ]]; then
        bad "no github user (GH_WORK_USER in $localenv)"
    elif token="$(gh auth token --user "$want" 2>/dev/null)"; then
        got="$(GH_TOKEN=$token gh api user -q .login 2>/dev/null || true)"
        [[ "$got" == "$want" ]] && ok "gh login: $got" || bad "gh token for $want resolves to '${got:-nothing}'"
    else
        bad "gh not logged in as $want (gh auth login)"
    fi
}

check() {
    check_account personal "$HOME" "$PERSONAL_USER"
    check_account work "$HOME/workspace/work" "$(work_user)"

    log "ssh config"
    # any IdentityFile under Host github.com is offered by ssh-agent before the
    # per-account key, so GitHub may log you in as the wrong user
    files="$(ssh -G github.com 2>/dev/null | sed -n 's/^identityfile //p' |
        grep -vE '/\.ssh/id_(rsa|ecdsa|ecdsa_sk|ed25519|ed25519_sk|xmss|dsa)$' || true)"
    if [[ -z "$files" ]]; then
        ok "no IdentityFile under Host github.com"
    else
        bad "remove 'IdentityFile $(tr '\n' ' ' <<<"$files")' under Host github.com"
    fi

    if ((fails)); then
        warn "$fails problem(s); fix and re-run ./install.sh git --check"
    else
        log "all good"
    fi
}

case "${1:-}" in
    --check) check ;;
    "") setup && check ;;
    *) sed -n '2,5p' "$0"; exit 1 ;;
esac
