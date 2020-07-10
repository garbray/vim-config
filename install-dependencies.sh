#!/bin/sh

export FGRN="\033[32m" # foreground green
echo "$FGRN copying dependencies"
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# install ohmyzsh
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

# install neovim
brew install neovim

#install dev dependencies
brew install yarn node deno

# install fonts
brew tap homebrew/cask-fonts
brew cask install font-fira-code
echo "review if the font is updated https://github.com/tonsky/FiraCode/wiki/Installing"

echo "$FGRN finish installing basic dependencies"
echo "$FGRN copying config files"
cp files/* ~/
