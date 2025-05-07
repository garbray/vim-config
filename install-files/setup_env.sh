#!/bin/sh
echo "Setting up environment..."

mkdir -p ~/.go
touch ~/.localenv

if [[ $PLATFORM == 'macos' ]]; then
    brew install koekeishiya/formulae/yabai
    brew install koekeishiya/formulae/skhd
    brew install skhd
    brew install trash-cli
    brew install --cask kitty
    brew install --cask ghostty
    brew install --cask raycast
    # replace for yabai / skhd
    brew install --cask nikitabobko/tap/aerospace
    brew tap FelixKratz/formulae
    brew install borders
fi

# xattr -d com.apple.quarantine /Applications/AeroSpace.app
# defaults write com.apple.dock expose-group-apps -bool true && killall Dock
# brew services start borders
