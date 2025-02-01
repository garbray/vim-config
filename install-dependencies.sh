#!/bin/sh

export FGRN="\033[32m" # foreground green
echo "$FGRN copying dependencies"
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# brew update
brew update

# install kitty
brew install kitty --cask
brew install ghostty # possible will replace kitty

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
# brew install zellij # alternative to tmux 

# install window manager
# brew install --cask amethyst

mkdir ~/.go

# install stow
brew install stow

# install python3
brew install python
brew install go
brew install lua
brew install luarocks
brew install yarn node deno
brew install rust
# node version manager 
brew install volta
# another package management for node modules
brew install pnpm
brew install ansible
brew install karabiner-elements --cask
# TODO: review if generate any additional benefits
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
# ls with batteries -> just for fun
brew install exa

brew install z

# brew install bat maybe not require to highlight preview TBD
echo "review if the font is updated https://github.com/tonsky/FiraCode/wiki/Installing"

echo "$FGRN finish installing basic dependencies"
echo "$FGRN copying config files"

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
#
# modern replacement for ls
brew install eza

# lua config
brew install ninja

brew install zsh-autosuggestions

brew install zsh-syntax-highlighting

# local env
touch ~/.localenv

# spotify, not necessary
# brew install spotify-tui
# brew install spotifyd
# start spotify process
brew install neofetch
brew install firefox

brew install --cask keycastr
# install packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

brew install numi
brew install TheZoraiz/ascii-image-converter/ascii-image-converter
brew install commitizen
brew install lazygit

brew install gh
# create alias commands to handle multiple github credentials accounts
# TODO create a way to store those in a safe fashion
# based on https://gist.github.com/yermulnik/017837c01879ed3c7489cc7cf749ae47
mkdir ~/.config/gh
touch ~/.config/gh/hosts.yml.personal
touch ~/.config/gh/hosts.yml.work
gh alias set personal '!cp ~/.config/gh/hosts.yml.personal ~/.config/gh/hosts.yml && gh auth status'
gh alias set work '!cp ~/.config/gh/hosts.yml.work ~/.config/gh/hosts.yml && gh auth status'

# spotifyd --no-daemon

brew install java11
# not sure if go is already installed
cargo install stylua

mkdir -p ~/.config/dap/
python -m venv ~/.config/dap/debugpy
~/.config/dap/debugpy -m pip install debugpy


if [[ $PLATFORM == 'macos' ]]; then
    brew install koekeishiya/formulae/yabai
    brew install koekeishiya/formulae/skhd
    brew install skhd
    brew install trash-cli
    brew install --cask raycast

# TODO: execute install script
brew install youtube-dl
brew install ffmpeg
brew install --cask docker
brew install jq tidy-html5
brew install act # run github actions locally
brew install tursodatabase/tap/turso # db cli turso


# node dependencies
npm install -g graphql-language-service-cli
npm install -g typescript typescript-language-server
npm i -g vscode-langservers-extracted

# htmlx
cargo install htmx-lsp

# config git
git config --global user.email "bryangarzonb@gmail.com"
git config --global user.name "Bryan Garzon"
git config --global core.editor "nvim"
git config --global rebase.updateRefs true
