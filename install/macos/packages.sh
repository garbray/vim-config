#!/usr/bin/env bash
set -euo pipefail
source "$REPO/install/lib.sh"

if ! command -v brew &>/dev/null; then
    log "installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# brew is not on PATH yet right after a fresh install
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x "$brew" ]] && eval "$("$brew" shellenv)" && break
done

log "brew bundle"
brew bundle --file="$REPO/install/macos/Brewfile" ||
    warn "some packages failed — re-run ./install.sh packages to retry"
