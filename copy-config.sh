#!/bin/sh

export FGRN="\033[32m" # foreground green
echo "$FGRN coping config files on the repo"
repoPath="$PWD"

#copy nvim
cp -R ~/.config/nvim $repoPath/files/.config
echo "$FGRN copy nivm file"

#copy tmux
cp ~/.tmux.conf $repoPath/files
echo "$FGRN copy tmux config file"

#copy zshrc
cp ~/.zshrc $repoPath/files
echo "$FGRN copy zshrc file"

#copy kitty config
cp -R ~/.config/kitty $repoPath/files/.config
echo "$FGRN copy kitty file"
echo "$FGRN COPY DONE"
