#!/bin/sh

export FGRN="\033[32m" # foreground green
echo "$FGRN copying dependencies"
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew update
brew update

# install kitty
brew install kitty --cask

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

# isntall stow
brew install stow

# install python3
brew install python
brew install go
brew install lua
brew install luarocks
brew install yarn node deno
brew install rust
brew install volta
brew install ansible
brew install karabiner-elements --cask
# TODO review if generate any aditional benefits
# brew install alfred --cask

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

/opt/homebrew/opt/fzf/install
# install fonts
brew tap homebrew/cask-fonts
brew install font-fira-code-nerd-font


# fuzzi finder list
brew install peco
# ls with bateries -> just for fun
brew install exa

brew install z

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
npm i -g vscode-css-languageserver-bin
npm i -g prettier
npm i -g graphql-language-service-cli
# npm i -g vscode-html-languageserver-bin
# looks like is reemplazed by this one
npm i -g vscode-langservers-extracted
npm i -g pyright
npm i -g typescript typescript-language-server
npm i -g vim-language-server
npm i -g yaml-language-server
npm i -g emmet-ls
npm install -g vscode-html-languageserver-bin
npm i -g vscode-langservers-extracted
npm install -g @tailwindcss/language-server
# omit until figure out how to handle the redirect on dev tools
# git config --global core.editor "nvim"

# lua config
brew install ninja

brew install zsh-autosuggestions

brew install zsh-syntax-highlighting

# local env
touch ~/.localenv

# spotify
brew install spotify-tui
brew install spotifyd
# start spotify process
brew install neofetch

brew install --cask keycastr

brew install numi

brew install gh
# create alias commands to handle multiple github credentials accounts
# TODO create a way to store those in a safe fashion
# based on https://gist.github.com/yermulnik/017837c01879ed3c7489cc7cf749ae47
touch ~/.config/sh/hosts.yml.personal
touch ~/.config/sh/hosts.yml.work
gh alias set personal '!cp ~/.config/gh/hosts.yml.personal ~/.config/gh/hosts.yml && gh auth status'
gh alias set work '!cp ~/.config/gh/hosts.yml.work ~/.config/gh/hosts.yml && gh auth status'

# spotifyd --no-daemon
