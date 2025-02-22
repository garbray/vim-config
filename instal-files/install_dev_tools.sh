#!/bin/sh
echo "Installing development tools..."

brew install python
brew install go
brew install rust
brew install lua
brew install luarocks
brew install yarn node deno
brew install volta pnpm
brew install ansible
brew install ninja
brew install stow
brew install efm-langserver
brew install tree-sitter
brew install java11

# Setup Python packages
python3 -m pip install --user --upgrade pynvim
pip install black flake8

# Node language servers
npm install -g neovim
npm install -g prettier typescript typescript-language-server
npm install -g bash-language-server vscode-langservers-extracted
npm install -g graphql-language-service-cli yaml-language-server
npm install -g vim-language-server emmet-ls @tailwindcss/language-server
