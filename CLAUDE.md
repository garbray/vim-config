# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal development environment configuration: Neovim as an IDE, dotfiles, and
installation automation for macOS.

## Key Components

### Configuration Files
- `dotfiles/.config/nvim/` - Neovim configuration (Lua, lazy.nvim)
- `dotfiles/.config/aerospace/` - window manager configuration
- `dotfiles/.zshrc` - Zsh shell configuration
- `dotfiles/.tmux.conf` - Tmux terminal multiplexer configuration

### Installation System
- `Brewfile` - every brew formula and cask; the bulk of the install
- `install-files/setup.sh` - orchestrates the install
- `install` - GNU Stow symlink management
- `.tool-versions` - runtime versions for mise

### Project Structure
- `tmuxSelector` - project/session selector script
- `task/` - task management configurations
- `docs/` - commands, mise, taskwarrior notes

## Common Commands

### Initial Setup
```bash
./install-files/setup.sh   # dependencies
./install                  # symlink dotfiles
```

### Development Workflow
```bash
tmuxSelector      # session selector (also linked as projectSelector)
lazygit           # git TUI
brew bundle       # sync packages after editing Brewfile
mise install      # sync runtimes after editing .tool-versions
```

## Neovim Configuration

Lua config on lazy.nvim. Every file under `lua/garbray/plugins/` is imported
automatically (`spec = { { import = "garbray.plugins" } }`), so a new plugin means a
new file there. There is no `after/plugin/` directory — a plugin's spec, options and
keymaps all live in its own file.

```
lua/garbray/
  init.lua      options.lua   keymaps.lua   lazy.lua   servers.lua
  plugins/  ai  colorscheme  completion  dap  editor  format
            git  lang  lsp  navigation  personal  treesitter  ui
```

Conventions:
- `servers.lua` is the single source of truth for LSP servers. It drives both
  `mason-lspconfig`'s `ensure_installed` and `vim.lsp.enable`. Add a server there only.
- Formatters, linters and debug adapters are installed by `mason-tool-installer`
  (configured in `plugins/lsp.lua`). `mason.nvim` itself has no `ensure_installed` option.
- Formatting is configured only in `plugins/format.lua` (conform.nvim).
- Plugin keymaps belong in that plugin's spec `keys =` table, so the plugin lazy-loads.
  Global keymaps go in `keymaps.lua`. Every keymap needs a `desc` for which-key.
- Never `require` a plugin inside a `keys = function()` body — lazy evaluates it during
  spec parsing, which loads the plugin at startup and defeats the lazy trigger.
- nvim-treesitter is on the **main** branch. There is no `nvim-treesitter.configs`;
  parsers are installed with `require("nvim-treesitter").install()` and highlighting is
  enabled per buffer with `vim.treesitter.start()`. It needs the `tree-sitter` CLI.
- Pickers, notifications, dashboard, terminal and scratch buffers come from snacks.nvim.
  Telescope is not installed.

AI integration: `claudecode.nvim` (keys under `<leader>A`) plus Copilot suggestions
through `blink-cmp-copilot`. Configured in `plugins/ai.lua` and `plugins/completion.lua`.

## Cursor/VSCode Integration

See `cursor/config.md` for Vim-style keybindings (leader `<space>`, `gd`/`gr`/`gi`
navigation, terminal and split management).

## Symlink Management

GNU Stow:
- `stow -t $HOME/.config -d dotfiles .config` creates the config symlinks
- manual symlinks for `.tmux.conf`, `.zshrc` and `tmuxSelector`
- global binary link for `projectSelector` in `/usr/local/bin/`
