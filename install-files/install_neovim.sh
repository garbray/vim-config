#!/bin/bash
set -e
echo "Installing Neovim extras..."

command -v stylua &>/dev/null || cargo install stylua

# nvim-treesitter's main branch generates parsers locally, so it needs the
# tree-sitter CLI (the `tree-sitter` formula is only the library).
command -v tree-sitter &>/dev/null || brew install tree-sitter-cli
