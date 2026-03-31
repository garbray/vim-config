#!/bin/bash
set -e
export FGRN="\033[32m"

echo "$FGRN Installing Homebrew..."
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add brew to PATH for this session (required on Apple Silicon and after fresh install)
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

echo "$FGRN Installing all dependencies via Brewfile..."
brew bundle --file="$(dirname "$0")/../Brewfile"

echo "$FGRN Installing shell tools..."
sh "$(dirname "$0")/install_shell_tools.sh"

echo "$FGRN Installing development tools..."
sh "$(dirname "$0")/install_dev_tools.sh"

echo "$FGRN Installing Neovim extras..."
sh "$(dirname "$0")/install_neovim.sh"

echo "$FGRN Configuring Git and GitHub CLI..."
sh "$(dirname "$0")/install_git_tools.sh"

echo "$FGRN Setting up environment..."
sh "$(dirname "$0")/setup_env.sh"

echo "$FGRN Setup complete!"
