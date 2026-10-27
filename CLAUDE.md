# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal development environment configuration: Neovim as an IDE, dotfiles, and
installation automation for macOS and omarchy (Arch + Hyprland).

## Layout

- `install.sh` - single entry point: detects OS (`macos` | `omarchy`), runs `packages`, `link`, `setup`
- `install/lib.sh` - logging, OS detection, backup of conflicting files before stow
- `install/common/` - cross-OS steps: `mise.sh`, `shell.sh` (oh-my-zsh, chsh), `git.sh`
- `install/macos/` - `packages.sh` + `Brewfile`
- `install/omarchy/` - `packages.sh` + `packages.txt` (installed with `yay -S --needed`)
- `dotfiles/common/` - stow package mirroring `$HOME`, used on every OS: `.zshrc`,
  `.tmux.conf`, `.tool-versions`, `.config/{nvim,zsh,tmux,lazygit,ghostty,kitty,task-warrior}`,
  `.local/bin/tmuxSelector`
- `dotfiles/macos/` - macOS-only stow package: aerospace, Karabiner
- `docs/`, `cursor/` - notes

Conventions:
- Config for every OS goes in `dotfiles/common`; OS-only config in `dotfiles/<os>`.
  A `dotfiles/omarchy` package is picked up automatically if created.
- A new package goes in both `install/macos/Brewfile` and `install/omarchy/packages.txt`.
- `.zshrc` must work on both OSes: probe paths (`/opt/homebrew/...` vs `/usr/share/...`)
  or branch on `$OSTYPE`; never hardcode a Homebrew path unguarded.
- Install scripts are bash (`#!/usr/bin/env bash`, `set -euo pipefail`), get `$REPO` from
  `install.sh`, and must be idempotent.

## Common Commands

```bash
./install.sh                 # everything
./install.sh link            # restow dotfiles after adding/moving files
./install.sh packages        # sync packages after editing Brewfile / packages.txt
tmuxSelector                 # tmux session selector
mise install                 # sync runtimes after editing .tool-versions
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

AI integration: `claudecode.nvim` (keys under `<leader>A`), configured in `plugins/ai.lua`.

## Cursor/VSCode Integration

See `cursor/config.md` for Vim-style keybindings (leader `<space>`, `gd`/`gr`/`gi`
navigation, terminal and split management).

## Symlink Management

GNU Stow, one call: `stow --restow -d dotfiles -t ~ common <os>`. `install.sh link` first
creates `~/.config` and `~/.local/bin` (so stow doesn't fold them into the repo) and moves
conflicting top-level entries to `~/.dotfiles-backup/<timestamp>/`.
