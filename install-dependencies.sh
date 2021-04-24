#!/bin/sh

export FGRN="\033[32m" # foreground green
echo "$FGRN copying dependencies"
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew update
brew update

# install kitty
brew cask install kitty

brew install zsh

# install ohmyzsh
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install zsh-syntax-highlighting

# install plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install ripgrep
brew install ripgrep

# install highlight
brew install highlight

# install tmux
brew install tmux

# install window manager
brew cask install amethyst

mkdir ~/.go

# install python3
brew install python
brew install go
brew install lua
brew install luarocks
brew install yarn node deno
brew install rust
brew install volta

# install python dependencies
python3 -m pip install --user --upgrade pynvim

brew install ranger
brew install tree-sitter
# install neovim until nightly release
brew install neovim --HEAD

#install dev dependencies
brew install efm-langserver

brew install speedtest-cli
brew install htop
brew install fzf
# install fonts
brew tap homebrew/cask-fonts
brew install font-fira-code-nerd-font

# brew install bat maybe not require to hightlight preview TBD
echo "review if the font is updated https://github.com/tonsky/FiraCode/wiki/Installing"

echo "$FGRN finish installing basic dependencies"
echo "$FGRN copying config files"
cp -r dotfiles/ ~/
cp dotfiles/.zshrc ~/
npm install -g neovim
pip install black
pip install flake8

# node servers dependencies
npm i -g bash-language-server
npm i -g graphql-language-service-cli
npm i -g vscode-html-languageserver-bin
npm i -g pyright
npm i -g typescript typescript-language-server
npm i -g vim-language-server
npm i -g yaml-language-server
git config --global core.editor "nvim"

# lua config
brew install ninja

brew install zsh-autosuggestions

# local env
touch ~/.localenv
