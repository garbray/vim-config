#!/usr/bin/env bash
set -euo pipefail
source "$REPO/install/lib.sh"

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log "installing oh-my-zsh"
    # KEEP_ZSHRC: ~/.zshrc is already our symlink
    KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# omarchy defaults to bash
zsh_path="$(command -v zsh)"
if [[ "$(basename "${SHELL:-}")" != zsh ]]; then
    log "setting login shell to $zsh_path"
    chsh -s "$zsh_path"
fi

mkdir -p "$HOME/.go"
touch "$HOME/.localenv"
