#!/bin/bash
set -e
echo "Installing development tools..."

# mise for runtime version management (replaces volta)
if ! command -v mise &>/dev/null; then
    curl https://mise.run | sh
fi
mise install

# Python packages
python3 -m pip install --user --upgrade pynvim
pip install black flake8

# Node: only the neovim bridge — LSPs managed by Mason.nvim inside Neovim
npm list -g neovim --depth=0 &>/dev/null || npm install -g neovim
