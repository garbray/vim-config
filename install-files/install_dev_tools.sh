#!/bin/bash
set -e
echo "Installing development tools..."

# mise for runtime version management (replaces volta)
curl https://mise.run | sh
mise install

# Python packages
python3 -m pip install --user --upgrade pynvim
pip install black flake8

# Node: only the neovim bridge — LSPs managed by Mason.nvim inside Neovim
npm install -g neovim
