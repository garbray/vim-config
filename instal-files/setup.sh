#!/bin/sh
export FGRN="\033[32m" # Foreground green

echo "$FGRN Installing Homebrew..."
sh install_brew.sh

echo "$FGRN Installing shell tools..."
sh install_shell_tools.sh

echo "$FGRN Installing development tools..."
sh install_dev_tools.sh

echo "$FGRN Installing Neovim..."
sh install_neovim.sh

echo "$FGRN Installing fonts..."
sh install_fonts.sh

echo "$FGRN Configuring Git and GitHub CLI..."
sh install_git_tools.sh

echo "$FGRN Installing miscellaneous tools..."
sh install_misc.sh

echo "$FGRN Installing browsers..."
sh install_browsers.sh

echo "$FGRN Installing Docker..."
sh install_docker.sh

echo "$FGRN Installing utility tools..."
sh install_utils.sh

echo "$FGRN Setting up environment..."
sh setup_env.sh

echo "$FGRN Setup complete!"
