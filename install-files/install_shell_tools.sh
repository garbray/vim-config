#!/bin/bash
set -e
echo "Installing shell tools..."

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# fzf post-install (key bindings + completion)
/opt/homebrew/opt/fzf/install --all --no-bash --no-fish
