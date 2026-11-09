#!/usr/bin/env bash
set -euo pipefail
source "$REPO/install/lib.sh"

log "configuring git"
git config --global core.editor "nvim"
git config --global rebase.updateRefs true

# identity per directory: personal by default, work under ~/workspace/work/
# (docs/github-accounts.md). name/email live in the included files.
git config --global --unset user.email || true
git config --global --unset user.name || true
# literal ~ on purpose: git expands it, so ~/.gitconfig stays portable
# shellcheck disable=SC2088
git config --global include.path "~/.config/git-accounts/personal.gitconfig"
# shellcheck disable=SC2088
git config --global "includeIf.gitdir:~/workspace/work/.path" "~/.config/git-accounts/work.gitconfig"

# machine-local work identity, kept out of this public repo
local_work="$HOME/.config/git/work.gitconfig"
if [[ ! -e "$local_work" ]]; then
    mkdir -p "$(dirname "$local_work")"
    email="" key=""
    if [[ -t 0 ]]; then
        read -rp "work git email (blank to skip): " email
        [[ -n "$email" ]] && read -rp "work ssh key [~/.ssh/id_work]: " key
    fi
    if [[ -n "$email" ]]; then
        printf '[user]\n\temail = %s\n[core]\n\tsshCommand = ssh -i %s -o IdentitiesOnly=yes\n' \
            "$email" "${key:-~/.ssh/id_work}" >"$local_work"
        log "wrote $local_work"
    else
        warn "no work identity: create $local_work (docs/github-accounts.md)"
    fi
fi

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

# work github user for the ghAccount zsh hook, machine-local
localenv="$HOME/.localenv"
touch "$localenv"
if ! grep -q '^export GH_WORK_USER=' "$localenv"; then
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
work_user="$(sed -n 's/^export GH_WORK_USER=//p' "$localenv" | tail -1)"
for user in garbray $work_user; do
    gh auth token --user "$user" >/dev/null 2>&1 && continue
    if [[ -t 0 ]]; then
        log "gh login for $user (pick that account in the browser)"
        gh auth login --hostname github.com --git-protocol ssh --web || warn "gh login for $user failed"
    else
        warn "gh not logged in as $user: run gh auth login"
    fi
done

# ssh keys referenced by the git identities
for f in "$HOME/.config/git-accounts/personal.gitconfig" "$local_work"; do
    [[ -e "$f" ]] || continue
    key="$(git config -f "$f" core.sshCommand | sed -n 's/.*-i \([^ ]*\).*/\1/p')"
    key="${key/#\~/$HOME}"
    [[ -z "$key" || -e "$key" ]] || warn "ssh key $key (from $f) not found"
done

# ~/.ssh/config is hand-edited; only check it
if ! ssh -G github.com 2>/dev/null | grep -qx 'identitiesonly yes'; then
    warn "ssh config: set 'IdentitiesOnly yes' for Host github.com (docs/github-accounts.md)"
fi
true
