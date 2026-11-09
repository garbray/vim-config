#!/usr/bin/env bash
# Git config + personal/work GitHub accounts (docs/github-accounts.md).
#
#   ./install.sh git           set up (prompts when run in a terminal), then check
#   ./install.sh git --check   only check: identity, ssh auth and gh per account
set -euo pipefail
source "$REPO/install/lib.sh"

PERSONAL_USER=garbray
WORK_DIR="$HOME/workspace/work"
LOCAL_WORK="$HOME/.config/git/work.gitconfig"
LOCALENV="$HOME/.localenv"

# ---------------------------------------------------------------- helpers ----

interactive() { [[ -t 0 ]]; }

# ask <var> <prompt>: read into <var>; stays empty when not interactive
ask() {
    printf -v "$1" '%s' ""
    interactive && read -rp "$2" "$1"
    true
}

# confirm <prompt> <default y|n>: default is used when not interactive
confirm() {
    local ans=""
    interactive && read -rp "$1 " ans
    [[ "${ans:-$2}" == [yY]* ]]
}

work_user() { sed -n 's/^export GH_WORK_USER=//p' "$LOCALENV" 2>/dev/null | tail -1; }
gh_token() { gh auth token --user "$1" 2>/dev/null; }
key_path() { echo "$HOME/.ssh/github_$1"; }

# ------------------------------------------------------------------ setup ----

git_defaults() {
    git config --global core.editor "nvim"
    git config --global rebase.updateRefs true
}

# identity per directory: personal by default, work under ~/workspace/work/.
# name/email live in the included files.
git_includes() {
    git config --global --unset user.email || true
    git config --global --unset user.name || true
    # literal ~ on purpose: git expands it, so ~/.gitconfig stays portable
    # shellcheck disable=SC2088
    git config --global include.path "~/.config/git-accounts/personal.gitconfig"
    # shellcheck disable=SC2088
    git config --global "includeIf.gitdir:~/workspace/work/.path" "~/.config/git-accounts/work.gitconfig"
}

# machine-local work email, kept out of this public repo
work_email() {
    local email
    if [[ ! -e "$LOCAL_WORK" ]]; then
        ask email "work git email (blank to skip): "
        if [[ -n "$email" ]]; then
            mkdir -p "$(dirname "$LOCAL_WORK")"
            printf '[user]\n\temail = %s\n' "$email" >"$LOCAL_WORK"
            log "wrote $LOCAL_WORK"
        else
            warn "no work email: create $LOCAL_WORK (docs/github-accounts.md)"
        fi
    fi
    # the key path is standard now and set in the repo's work.gitconfig
    if git config -f "$LOCAL_WORK" core.sshCommand >/dev/null 2>&1; then
        git config -f "$LOCAL_WORK" --unset core.sshCommand
        log "dropped core.sshCommand from $LOCAL_WORK (now $(key_path work))"
    fi
}

# work github user for the ghAccount zsh hook, machine-local
work_gh_user() {
    local user
    touch "$LOCALENV"
    [[ -n "$(work_user)" ]] && return
    ask user "work github username (blank to skip): "
    if [[ -n "$user" ]]; then
        printf '\nexport GH_WORK_USER=%s\n' "$user" >>"$LOCALENV"
        log "added GH_WORK_USER to $LOCALENV"
    else
        warn "set GH_WORK_USER in $LOCALENV for the gh account hook"
    fi
}

# both accounts in gh's keyring; login opens a browser, so terminal only
gh_logins() {
    local user
    for user in "$PERSONAL_USER" $(work_user); do
        gh_token "$user" >/dev/null && continue
        if interactive; then
            log "gh login for $user (pick that account in the browser)"
            gh auth login --hostname github.com --git-protocol ssh --web || warn "gh login for $user failed"
        else
            warn "gh not logged in as $user: run gh auth login"
        fi
    done
}

# create_key <account>: link an existing key to ~/.ssh/github_<account>, or generate one
create_key() {
    local acct=$1 key src
    key="$(key_path "$acct")"
    log "ssh key for $acct -> $key"
    find "$HOME/.ssh" -maxdepth 1 -name '*.pub' ! -name 'github_*' | sed 's/\.pub$//; s|^|  |'
    ask src "existing $acct private key to reuse (blank = generate new): "
    if [[ -z "$src" ]]; then
        ssh-keygen -t ed25519 -C "github_$acct $(hostname -s)" -f "$key"
        return
    fi
    src="${src/#\~/$HOME}"
    if [[ ! -f "$src" || ! -f "$src.pub" ]]; then
        warn "$src or $src.pub not found; skipped $acct key"
        return 1
    fi
    ln -s "$src" "$key"
    ln -s "$src.pub" "$key.pub"
    log "linked $key -> $src"
}

# upload_key <account> <github user>: add the public key to that account if missing
upload_key() {
    local acct=$1 user=$2 key token
    key="$(key_path "$acct")"
    if ! token="$(gh_token "$user")"; then
        warn "gh not logged in as $user; can't check $key.pub on GitHub"
        return
    fi
    GH_TOKEN=$token gh api user/keys -q '.[].key' 2>/dev/null |
        grep -qF "$(awk '{print $2}' "$key.pub")" && return
    if confirm "add $key.pub to GitHub user $user? [Y/n]" "$(interactive && echo y || echo n)"; then
        GH_TOKEN=$token gh ssh-key add "$key.pub" --title "$(hostname -s) github_$acct" ||
            warn "upload failed (key already on another account?)"
    else
        warn "$key.pub is not on GitHub user $user"
    fi
}

# ssh_key <account> <github user>
ssh_key() {
    local acct=$1 user=$2
    mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
    if [[ ! -e "$(key_path "$acct")" ]]; then
        if ! interactive; then
            warn "no $(key_path "$acct"): run ./install.sh git in a terminal"
            return
        fi
        create_key "$acct" || return 0
    fi
    [[ -z "$user" ]] || upload_key "$acct" "$user"
}

# the old setup copied hosts.yml snapshots around; ghAccount replaces it
old_gh_cleanup() {
    local a f
    for a in personal work; do
        gh alias list 2>/dev/null | grep -q "^$a:" && gh alias delete "$a" >/dev/null
    done
    # the snapshots hold plain-text tokens
    for f in "$HOME"/.config/gh/hosts.yml.{personal,work}; do
        [[ -e "$f" ]] || continue
        if confirm "delete old token snapshot $f? [y/N]" n; then
            rm "$f"
            warn "deleted $f; revoke its token at https://github.com/settings/applications"
        else
            warn "$f holds a plain-text token: delete it and revoke the token"
        fi
    done
    true
}

setup() {
    log "configuring git"
    git_defaults
    git_includes
    work_email
    work_gh_user
    gh_logins
    ssh_key personal "$PERSONAL_USER"
    ssh_key work "$(work_user)"
    old_gh_cleanup
}

# ------------------------------------------------------------------ check ----

fails=0
ok() { printf "  \033[32m✓\033[0m %s\n" "$*"; }
bad() { printf "  \033[31m✗\033[0m %s\n" "$*"; fails=$((fails + 1)); }

# repo_config <dir> <key>: the value a fresh repo under <dir> would get
repo_config() {
    local tmp value
    mkdir -p "$1"
    tmp="$(mktemp -d "$1/.git-accounts-check.XXXXXX")"
    git init -q "$tmp"
    value="$(git -C "$tmp" config "$2" || true)"
    rm -rf "$tmp"
    echo "$value"
}

check_email() {
    local email
    email="$(repo_config "$1" user.email)"
    if [[ -n "$email" ]]; then ok "commit email: $email"; else bad "no commit email"; fi
}

# check_ssh <dir> <github user>: GitHub answers "Hi <user>!" for the first key it accepts
check_ssh() {
    local ssh_cmd key got
    ssh_cmd="$(repo_config "$1" core.sshCommand)"
    key="$(sed -n 's/.*-i \([^ ]*\).*/\1/p' <<<"$ssh_cmd")"
    key="${key/#\~/$HOME}"
    if [[ -z "$key" ]]; then
        bad "no ssh key in core.sshCommand"
    elif [[ ! -e "$key" ]]; then
        bad "ssh key $key does not exist"
    else
        got="$(eval "$ssh_cmd -o BatchMode=yes -T git@github.com" 2>&1 |
            sed -n 's/^Hi \([^!]*\)!.*/\1/p' || true)"
        if [[ -n "$2" && "$got" == "$2" ]]; then
            ok "ssh key $key -> $got"
        else
            bad "ssh key $key authenticates as '${got:-nothing}', want '$2'"
        fi
    fi
}

# check_gh <github user>
check_gh() {
    local token got
    if [[ -z "$1" ]]; then
        bad "no github user (GH_WORK_USER in $LOCALENV)"
    elif token="$(gh_token "$1")"; then
        got="$(GH_TOKEN=$token gh api user -q .login 2>/dev/null || true)"
        if [[ "$got" == "$1" ]]; then ok "gh login: $got"; else bad "gh token for $1 resolves to '${got:-nothing}'"; fi
    else
        bad "gh not logged in as $1 (gh auth login)"
    fi
}

# check_account <label> <dir whose repos get this account> <github user>
check_account() {
    log "$1 (expect github user: ${3:-?})"
    check_email "$2"
    check_ssh "$2" "$3"
    check_gh "$3"
}

# any IdentityFile under Host github.com is offered by ssh-agent before the
# per-account key, so GitHub may log you in as the wrong user
check_ssh_config() {
    local files
    log "ssh config"
    files="$(ssh -G github.com 2>/dev/null | sed -n 's/^identityfile //p' |
        grep -vE '/\.ssh/id_(rsa|ecdsa|ecdsa_sk|ed25519|ed25519_sk|xmss|dsa)$' || true)"
    if [[ -z "$files" ]]; then
        ok "no IdentityFile under Host github.com"
    else
        bad "remove 'IdentityFile $(tr '\n' ' ' <<<"$files")' under Host github.com"
    fi
}

check() {
    check_account personal "$HOME" "$PERSONAL_USER"
    check_account work "$WORK_DIR" "$(work_user)"
    check_ssh_config
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
