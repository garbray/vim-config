# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal development environment configuration repository focused on Vim/Neovim as an IDE, with comprehensive dotfiles and installation automation for macOS development environments.

## Key Components

### Configuration Files
- `dotfiles/.config/nvim/` - Neovim configuration with Lua-based plugin system
- `dotfiles/.config/aerospace/` - Window manager configuration 
- `dotfiles/.zshrc` - Zsh shell configuration
- `dotfiles/.tmux.conf` - Tmux terminal multiplexer configuration

### Installation System
- `install` - Main installation script using GNU Stow for symlink management
- `install-files/setup.sh` - Orchestrates all installation scripts
- `install-files/install_*.sh` - Modular installation scripts for different tool categories

### Project Structure
- `tmuxSelector` - Custom project/session selector script
- `task/` - Task management configurations
- `docs/` - Documentation including commands and task warrior setup

## Common Commands

### Initial Setup
```bash
# Install all dependencies and configure dotfiles
./install-files/setup.sh

# Create symlinks for dotfiles (main installation)
./install
```

### Development Workflow
```bash
# Start tmux session selector
tmuxSelector
# or via global link
projectSelector

# Git operations with lazygit
lazygit
```

### Neovim AI Integration
The setup includes Copilot and Avante.nvim plugins for AI assistance:
- Provider: Copilot (configured in `dotfiles/.config/nvim/lua/garbray/plugins/ai.lua`)
- Auto-suggestions disabled by default
- Image pasting support via img-clip.nvim

### Cursor/VSCode Integration
For Cursor/VSCode users, see `cursor/config.md` for Vim-style keybindings configuration including:
- Leader key: `<space>`
- Navigation shortcuts (gd, gr, gi, etc.)
- Terminal and split management

## Installation Scripts Organization

The modular installation system in `install-files/` handles:
- `install_brew.sh` - Homebrew package manager
- `install_shell_tools.sh` - Shell utilities and CLI tools
- `install_dev_tools.sh` - Development tools and languages
- `install_neovim.sh` - Neovim and plugins
- `install_git_tools.sh` - Git and GitHub CLI
- `install_fonts.sh` - Development fonts
- `install_utils.sh` - System utilities
- `install_browsers.sh` - Web browsers
- `setup_env.sh` - Environment configuration

## Symlink Management

The repository uses GNU Stow for dotfile management:
- `stow -t $HOME/.config -d dotfiles .config` creates config symlinks
- Manual symlinks for `.tmux.conf`, `.zshrc`, and `tmuxSelector`
- Global binary link for `projectSelector` in `/usr/local/bin/`