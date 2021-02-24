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

#copy zhrc alias
cp ~/.config/zsh $repoPath/files/.config
echo "$FGRN copy zsh import file"

#copy kitty config
cp -R ~/.config/kitty $repoPath/files/.config
echo "$FGRN copy kitty file"

#copy tmux config
cp -R ~/.config/tmux $repoPath/files/.config
echo "$FGRN copy tmux file"
echo "$FGRN COPY DONE"
