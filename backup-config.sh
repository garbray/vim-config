#!/bin/sh

export FGRN="\033[32m" # foreground green
echo "$FGRN coping config files on the repo"
repoPath="$PWD"

#copy nvim
cp -R ~/.config/nvim $repoPath/dotfiles/config
echo "$FGRN copy nivm file"

#copy tmux
cp ~/.tmux.conf $repoPath/dotfiles
echo "$FGRN copy tmux config file"

#copy zshrc
cp ~/.zshrc $repoPath/dotfiles
echo "$FGRN copy zshrc file"

#copy zhrc alias
cp -R ~/.config/zsh $repoPath/dotfiles/config
echo "$FGRN copy zsh import file"

#copy kitty config
cp -R ~/.config/kitty $repoPath/dotfiles/config
echo "$FGRN copy kitty file"

#copy tmux config
cp -R ~/.config/tmux $repoPath/dotfiles/config
echo "$FGRN copy tmux file"
echo "$FGRN COPY DONE"

#copy skhd config
cp -R ~/.config/skhd $repoPath/dotfiles/config
echo "$FGRN copy skhd file"
echo "$FGRN COPY DONE"

#copy yabai config
cp -R ~/.config/yabai $repoPath/dotfiles/config
echo "$FGRN copy yabai file"
echo "$FGRN COPY DONE"
