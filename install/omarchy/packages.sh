#!/usr/bin/env bash
set -euo pipefail
source "$REPO/install/lib.sh"

# omarchy ships yay, which covers both the official repos and the AUR
mapfile -t pkgs < <(grep -Ev '^\s*(#|$)' "$REPO/install/omarchy/packages.txt")

log "yay -S ${#pkgs[@]} packages"
yay -S --needed --noconfirm "${pkgs[@]}"
