# Vim/Neovim IDE Setup

Personal macOS dev env: Neovim+Tmux+dotfiles, automated install, AI plugins.

## Features
- Neovim IDE (LSP, Copilot, Avante)
- Tmux session mgmt
- Fast nav, hotkeys, minimal mouse
- Full dotfiles, modular install scripts

## Requirements
- macOS (tested on Sonoma+)
- Git
- Xcode Command Line Tools: `xcode-select --install`

## Installation

### 1. Clone
```sh
git clone https://github.com/<your-username>/vim-config.git ~/workspace/personal/vim-config
cd ~/workspace/personal/vim-config
```

### 2. Install all dependencies
```sh
cd install-files
./setup.sh
cd ..
```
Runs all `install_*.sh` scripts in order: Homebrew → shell tools → dev tools → Neovim → fonts → Git → misc → browsers → utils → env setup.

### 3. Symlink dotfiles
```sh
./install
```
Uses GNU Stow to link configs and symlinks `.zshrc`, `.tmux.conf`, `tmuxSelector`.

### 4. Reload shell & open Neovim
```sh
source ~/.zshrc
nvim  # lazy.nvim auto-installs plugins on first launch
```

## Main Configs
- `dotfiles/.config/nvim/` (Neovim, Lua plugins)
- `dotfiles/.zshrc`, `.tmux.conf`, `.config/aerospace/`
- `install-files/` (all install scripts)

## Dependencies (auto-installed)

### Core
- Homebrew, GNU Stow, Python, Go, Rust, Lua, Node, Deno, Yarn, Volta, pnpm, Java11, Bun, Ansible, Ninja

### Neovim/Editor
- neovim (HEAD), stylua, efm-langserver, tree-sitter, pynvim, black, flake8
- node: neovim, prettier, typescript, typescript-language-server, bash-language-server, vscode-langservers-extracted, graphql-language-service-cli, yaml-language-server, vim-language-server, emmet-ls, @tailwindcss/language-server
- AI: @anthropic-ai/claude-code, Copilot, Avante.nvim

### Shell/CLI
- zsh, oh-my-zsh, zsh-syntax-highlighting, zsh-autosuggestions, fzf, tmux, ripgrep, highlight, ranger, exa, z, peco, speedtest-cli, htop, lazygit, commitizen

### Fonts
- FiraCode Nerd Font

### Browsers
- firefox, zen-browser

### Utils
- jq, tidy-html5, act, turso, xh, curlie, youtube-dl, ffmpeg, taskwarrior-tui, webp, imagemagick

### Misc
- neofetch, keycastr, numi, ascii-image-converter

## Keyboard Speed (macOS)
settings → accessibility → keyboard → key repeat → fast

## Multi-Git Account Example
```sh
ssh-keygen -t rsa -b 4096 -C "your-email"
ssh-add --apple-use-keychain ~/.ssh/id_rsa_another
# ~/.ssh/config example:
Host work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa
Host alias
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_another
```

## More
- [CLAUDE.md](./CLAUDE.md) (repo structure, commands)
- [tmux usage](./tmux/README.md)
- [vim cheatsheet](./cheatsheet-vim.md)
- [cursor/config.md](./cursor/config.md) (VSCode/Cursor keybinds)





