#!/bin/sh
echo "Installing shell tools..."

brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install zsh-syntax-highlighting zsh-autosuggestions

brew install fzf
/opt/homebrew/opt/fzf/install

brew install tmux
brew install ripgrep
brew install highlight
brew install ranger
brew install exa
brew install z
brew install peco
brew install speedtest-cli
brew install htop
brew install lazygit
brew install commitizen
