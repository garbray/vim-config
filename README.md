# Vim/Neovim IDE Setup

Personal dev env: Neovim + Tmux + zsh dotfiles, one install script for **macOS** and
**[omarchy](https://omarchy.org)** (Arch + Hyprland).

## Features
- Neovim IDE: LSP via Mason, blink.cmp completion, Copilot suggestions, Claude Code integration
- Tmux session management via `tmuxSelector`
- macOS: Aerospace tiling. omarchy: keeps its own Hyprland setup
- Dotfiles as GNU Stow packages, per-OS package lists

## Installation

`./install.sh` detects the OS on its own: macOS from `uname`, omarchy from
`~/.local/share/omarchy`. Anything else exits with an error. It runs three steps in order:

| Step | macOS | omarchy |
|---|---|---|
| `packages` | installs Homebrew if missing, then `brew bundle` from [`Brewfile`](./install/macos/Brewfile) | `yay -S --needed` from [`packages.txt`](./install/omarchy/packages.txt) |
| `link` | stows `dotfiles/common` + `dotfiles/macos` into `~` | stows `dotfiles/common` into `~` |
| `setup` | mise runtimes, oh-my-zsh, git/gh config | same, and switches login shell from bash to zsh |

### macOS

1. Install the Xcode Command Line Tools (provides `git`):
   ```sh
   xcode-select --install
   ```
2. Clone and run:
   ```sh
   git clone https://github.com/garbray/vim-config.git ~/workspace/personal/vim-config
   cd ~/workspace/personal/vim-config
   ./install.sh
   ```
   Homebrew asks for your password once.
3. Open a new terminal (Ghostty or Kitty), then:
   ```sh
   gh auth login       # GitHub CLI
   nvim                # first launch installs plugins, LSPs, treesitter parsers
   ```
4. Open AeroSpace and Karabiner-Elements once and grant them Accessibility permission
   (System Settings → Privacy & Security → Accessibility).

### omarchy

1. Install [omarchy](https://omarchy.org) first. It provides `git`, `yay` and Hyprland.
2. Clone and run:
   ```sh
   git clone https://github.com/garbray/vim-config.git ~/workspace/personal/vim-config
   cd ~/workspace/personal/vim-config
   ./install.sh
   ```
   `yay` asks for your sudo password, `chsh` asks for your user password.
3. Log out and back in so zsh becomes the login shell.
4. Open a terminal, then:
   ```sh
   gh auth login
   nvim
   ```

What changes on omarchy:
- omarchy's LazyVim config (`~/.config/nvim`), plus its `ghostty` and `kitty` configs, are
  replaced by this repo's. The originals are moved to `~/.dotfiles-backup/<timestamp>/`.
  To go back, delete the symlink and move the backup back:
  ```sh
  rm ~/.config/nvim && mv ~/.dotfiles-backup/<timestamp>/.config/nvim ~/.config/nvim
  ```
- Hyprland, Waybar, Walker, Alacritty and omarchy themes are not touched.
- Default shell changes from bash to zsh (oh-my-zsh).

### Running one step

```sh
./install.sh packages    # after editing Brewfile / packages.txt
./install.sh link        # after adding, moving or removing files in dotfiles/
./install.sh setup       # runtimes, shell, git again
```

Every step can be re-run safely. `link` needs `stow`, which the `packages` step installs.

## Day to day

| Task | How |
|---|---|
| Change a config | edit it in the repo; `~` already points at it |
| Add a config for both OSes | put it under `dotfiles/common/` with its path relative to `~`, then `./install.sh link` |
| Add a config for one OS | same, under `dotfiles/macos/` or `dotfiles/omarchy/` (created when needed, picked up automatically) |
| Add a package | add it to both `install/macos/Brewfile` and `install/omarchy/packages.txt`, then `./install.sh packages` |
| Change a runtime version | edit `dotfiles/common/.tool-versions`, then `mise install` |
| Machine-only secrets / env vars | `~/.localenv` (sourced by `.zshrc`, not in the repo) |

## Layout

```
install.sh                   # entry point: detects OS, runs steps
install/
  lib.sh                     # logging, OS detection, backup-before-stow
  common/  mise.sh shell.sh git.sh
  macos/   packages.sh Brewfile
  omarchy/ packages.sh packages.txt
dotfiles/                    # stow packages, each mirrors $HOME
  common/  .zshrc .tmux.conf .tool-versions
           .config/{nvim,zsh,tmux,lazygit,ghostty,kitty,task-warrior}
           .local/bin/tmuxSelector
  macos/   .config/{aerospace,Karabiner}
docs/  cursor/               # notes
```

## Neovim

Lua config on [lazy.nvim](https://github.com/folke/lazy.nvim). One file per concern; every
file under `plugins/` is imported automatically, so adding a plugin means adding one file.

```
dotfiles/common/.config/nvim/
├── init.lua
└── lua/garbray/
    ├── init.lua      # leader, then options/keymaps/lazy
    ├── options.lua   # vim.opt settings
    ├── keymaps.lua   # global keymaps
    ├── lazy.lua      # lazy.nvim bootstrap + spec import
    ├── servers.lua   # LSP server list (drives Mason and vim.lsp.enable)
    └── plugins/
        ├── ai.lua           # claudecode.nvim
        ├── colorscheme.lua  # rose-pine + transparency
        ├── completion.lua   # blink.cmp + Copilot source
        ├── dap.lua          # nvim-dap, adapters, UI
        ├── editor.lua       # flash, surround, autopairs, sleuth, undotree, todo-comments
        ├── format.lua       # conform.nvim
        ├── git.lua          # gitsigns, fugitive
        ├── lang.lua         # prisma, render-markdown
        ├── lsp.lua          # Mason, lspconfig, trouble, goto-preview
        ├── navigation.lua   # harpoon
        ├── personal.lua     # simple-term
        ├── treesitter.lua   # nvim-treesitter (main branch) + autotag
        └── ui.lua           # lualine, snacks, noice, which-key, pickers
```

Leader is `<space>`. Press `<leader>` and wait for [which-key](https://github.com/folke/which-key.nvim)
to list everything; `<leader>?` shows buffer-local maps.

| Keys | |
|---|---|
| `<leader>pf` / `<C-p>` / `<leader>ps` | find files / git files / grep prompt |
| `<leader>S…` | full picker namespace — `Sf` files, `Sg` live grep, `Sb` buffers, `Sk` keymaps, `Sq` quickfix, `Sp` all pickers |
| `<leader>t1`-`t4`, `<leader>ST` | terminals 1-4 (per project), pick an open terminal |
| `<C-e>`, `<leader>aa`, `<C-h/j/k/l>` | harpoon menu, add file, jump to slots 1-4 |
| `<leader>gd` / `<leader>gr` / `K` / `<leader>ca` / `<leader>rn` | LSP definition / references / hover / code action / rename |
| `<leader>f` | format buffer (conform) |
| `<leader>d…` | debugger — `dt` breakpoint, `dc` continue, `di/do/du` step |
| `<leader>x…` | trouble — `xx` diagnostics, `xQ` quickfix |
| `<leader>A…` | Claude Code — `Ac` toggle, `As` send selection, `Ay/An` accept/deny diff |
| `<leader>g…` | git — `gs` fugitive status, `lg` lazygit |

Pickers, notifications, dashboard, terminal and scratch buffers all come from
[snacks.nvim](https://github.com/folke/snacks.nvim); there is no telescope.

LSP servers, formatters, linters and debug adapters are installed by Mason.
Add a server to `lua/garbray/servers.lua` and it is both installed and enabled.

## Dependencies

macOS: [`install/macos/Brewfile`](./install/macos/Brewfile). omarchy:
[`install/omarchy/packages.txt`](./install/omarchy/packages.txt). Highlights:

- **Editor**: neovim, tree-sitter-cli
- **Languages/runtimes**: python, go, lua, luarocks, node, deno, bun, pnpm, openjdk, uv
- **Runtime versions**: mise, from `~/.tool-versions` (linked from `dotfiles/common`)
- **Shell/CLI**: zsh, zsh-syntax-highlighting, zsh-autosuggestions, fzf, tmux, ripgrep, eza, z, htop, lazygit, ranger, just, csvlens, trash-cli
- **Music**: [cliamp](https://github.com/bjarneo/cliamp)
- **Window management (macOS)**: aerospace, borders
- **Terminals**: ghostty, kitty
- **Utils**: jq, xh, curlie, ffmpeg, imagemagick, yt-dlp, act, taskwarrior-tui

Not from a package manager: oh-my-zsh, mise on macOS (`curl mise.run`). Language servers,
formatters (stylua, black, …) and debug adapters are installed by Mason inside Neovim.

## Keyboard Speed (macOS)
Settings → Accessibility → Keyboard → Key repeat → fast

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
- [CLAUDE.md](./CLAUDE.md) — repo structure and commands
- [docs/commands.md](./docs/commands.md) — command notes
- [docs/mise.md](./docs/mise.md) — runtime version management
- [docs/task-warrior.md](./docs/task-warrior.md) — taskwarrior setup
- [cursor/config.md](./cursor/config.md) — VSCode/Cursor keybindings
