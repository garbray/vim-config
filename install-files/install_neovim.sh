#!/bin/sh
echo "Installing Neovim..."

brew install neovim --HEAD

# Install Packer (Neovim package manager)
# git clone --depth 1 https://github.com/wbthomason/packer.nvim \
#     ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# mkdir -p ~/.config/dap/
# python -m venv ~/.config/dap/debugpy
# ~/.config/dap/debugpy -m pip install debugpy

cargo install stylua
