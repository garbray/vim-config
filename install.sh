#!/usr/bin/env bash
# Usage: ./install.sh [all|packages|link|setup]
#
#   packages  OS packages (Homebrew on macOS, yay on omarchy, apt + Homebrew on ubuntu)
#   link      stow dotfiles/common + dotfiles/<os> into $HOME
#   setup     runtimes (mise), shell (oh-my-zsh), git, taskwarrior
#   all       the three above, in that order (default)
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export REPO
source "$REPO/install/lib.sh"

OS="$(detect_os)"
[[ "$OS" == unsupported ]] && { warn "only macOS, omarchy and ubuntu are supported"; exit 1; }
log "detected $OS"

packages() {
    bash "$REPO/install/$OS/packages.sh"
}

link() {
    local backup="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
    local pkgs=(common)
    [[ -d "$REPO/dotfiles/$OS" ]] && pkgs+=("$OS")

    # stow folds missing dirs into a single symlink; these must stay real dirs
    mkdir -p "$HOME/.config" "$HOME/.local/bin"
    for pkg in "${pkgs[@]}"; do
        backup_conflicts "$REPO/dotfiles/$pkg" "$backup"
    done
    log "linking ${pkgs[*]}"
    stow --restow -d "$REPO/dotfiles" -t "$HOME" "${pkgs[@]}"
}

setup() {
    for step in mise shell git taskwarrior; do
        bash "$REPO/install/common/$step.sh"
    done
}

case "${1:-all}" in
    packages) packages ;;
    link) link ;;
    setup) setup ;;
    all) packages && link && setup ;;
    *) sed -n '2,8p' "$0"; exit 1 ;;
esac

log "done"
