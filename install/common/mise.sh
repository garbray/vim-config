#!/usr/bin/env bash
# Runtimes from ~/.tool-versions (linked from dotfiles/common).
set -euo pipefail
source "$REPO/install/lib.sh"

if ! command -v mise &>/dev/null && [[ ! -x "$HOME/.local/bin/mise" ]]; then
    log "installing mise"
    curl -fsSL https://mise.run | sh
fi
export PATH="$HOME/.local/bin:$PATH"

log "mise install"
cd "$HOME" && mise install
