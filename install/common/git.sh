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
true
