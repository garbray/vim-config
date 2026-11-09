#!/usr/bin/env bash
set -euo pipefail
source "$REPO/install/lib.sh"

mapfile -t pkgs < <(grep -Ev '^\s*(#|$)' "$REPO/install/ubuntu/apt.txt")
log "apt-get install ${#pkgs[@]} packages"
sudo apt-get update
sudo apt-get install -y "${pkgs[@]}"

brew=/home/linuxbrew/.linuxbrew/bin/brew
if [[ ! -x "$brew" ]]; then
    log "installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$("$brew" shellenv)"

log "brew bundle"
brew bundle --file="$REPO/install/ubuntu/Brewfile" ||
    warn "some packages failed — re-run ./install.sh packages to retry"

if ! command -v ghostty &>/dev/null; then
    log "installing ghostty (snap)"
    sudo snap install ghostty --classic || warn "ghostty install failed"
fi

fonts="$HOME/.local/share/fonts/FiraCodeNerdFont"
if [[ ! -d "$fonts" ]]; then
    log "installing FiraCode Nerd Font"
    mkdir -p "$fonts"
    curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz |
        tar -xJ -C "$fonts"
    fc-cache -f "$fonts"
fi
