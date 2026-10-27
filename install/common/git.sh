#!/usr/bin/env bash
set -euo pipefail
source "$REPO/install/lib.sh"

log "configuring git"
git config --global user.email "bryangarzonb@gmail.com"
git config --global user.name "Bryan Garzon"
git config --global core.editor "nvim"
git config --global rebase.updateRefs true

# `gh personal` / `gh work` swap between two saved gh logins
mkdir -p "$HOME/.config/gh"
touch "$HOME/.config/gh/hosts.yml.personal" "$HOME/.config/gh/hosts.yml.work"
aliases="$(gh alias list 2>/dev/null || true)"
grep -q "^personal" <<<"$aliases" ||
    gh alias set personal '!cp ~/.config/gh/hosts.yml.personal ~/.config/gh/hosts.yml && gh auth status'
grep -q "^work" <<<"$aliases" ||
    gh alias set work '!cp ~/.config/gh/hosts.yml.work ~/.config/gh/hosts.yml && gh auth status'
