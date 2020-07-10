#!/bin/sh
#function copyTmWebcommon() {
#  myvar="$PWD"
#  echo 'running yarn build'
#  $TM_WEBCOMMON && yarn build
#  echo 'yarn build completed'
#  echo 'copying dist files'
#  cp $TM_WEBCOMMON/dist/* $TM_AACU_UI/node_modules/webapp-common-ui/dist/
#  echo -e "$FGRN UPDATED NEW VERSION ON NODE_MODULES"
#  echo -e "$FYEL ====DONT FORGET TO ROLLBACK YOUR CHANGES AFTER YOU ARE DONE===="
#  cd "$myvar"
#}
export FGRN="\033[32m" # foreground green
echo -e "$FGRN coping config files on the repo"
repoPath="$PWD"
#copy nvim
cp -R ~/.config/nvim $repoPath/files/.config
echo -e "$FGRN copy nivm file"
#copy tmux
cp ~/.tmux.conf $repoPath/files
echo -e "$FGRN copy tmux config file"

#copy zshrc
cp ~/.zshrc $repoPath/files
echo -e "$FGRN copy zshrc file"

#copy kitty config
cp -R ~/.config/kitty $repoPath/files/.config
echo -e "$FGRN copy kitty file"
echo -e "$FGRN COPY DONE"
