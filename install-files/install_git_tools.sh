#!/bin/bash
set -e
echo "Configuring Git and GitHub CLI..."

mkdir -p ~/.config/gh
touch ~/.config/gh/hosts.yml.personal ~/.config/gh/hosts.yml.work

gh alias set personal '!cp ~/.config/gh/hosts.yml.personal ~/.config/gh/hosts.yml && gh auth status'
gh alias set work '!cp ~/.config/gh/hosts.yml.work ~/.config/gh/hosts.yml && gh auth status'

git config --global user.email "bryangarzonb@gmail.com"
git config --global user.name "Bryan Garzon"
git config --global core.editor "nvim"
git config --global rebase.updateRefs true
