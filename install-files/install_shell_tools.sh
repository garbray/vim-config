#!/bin/bash
set -e
echo "Installing shell tools..."

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "oh-my-zsh already installed, skipping."
fi

# fzf post-install (key bindings + completion)
/opt/homebrew/opt/fzf/install --all --no-bash --no-fish
