#!/bin/sh

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew update
brew update

# install kitty
brew cask install kitty

# install plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install ripgrep
brew install ripgrep

# install highlight
brew install highlight

# install tmux
brew install tmux

# install python3
brew install python

# install python dependencies
python3 -m pip install --user --updrage pynvim
