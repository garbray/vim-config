#!/usr/bin/env bash
set -euo pipefail
source "$REPO/install/lib.sh"

# check the entry file, not the dir: a failed clone leaves a partial dir behind
if [[ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
    log "installing oh-my-zsh"
    rm -rf "$HOME/.oh-my-zsh"
    git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

# omarchy and ubuntu default to bash
zsh_path="$(command -v zsh)"
if [[ "$(basename "${SHELL:-}")" != zsh ]]; then
    log "setting login shell to $zsh_path"
    chsh -s "$zsh_path"
fi

mkdir -p "$HOME/.go"
touch "$HOME/.localenv"
