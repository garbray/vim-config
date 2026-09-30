#!/bin/bash
set -e
echo "Installing Neovim extras..."

command -v stylua &>/dev/null || cargo install stylua
