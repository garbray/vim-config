# Vim/Neovim IDE Setup

Personal dev env: Neovim + Tmux + zsh dotfiles, one install script for **macOS** and
**[omarchy](https://omarchy.org)** (Arch + Hyprland).

## Features
- Neovim IDE: LSP via Mason, blink.cmp completion, Copilot suggestions, Claude Code integration
- Tmux session management via `tmuxSelector`
- macOS: Aerospace tiling. omarchy: keeps its own Hyprland setup
- Dotfiles as GNU Stow packages, per-OS package lists

## Requirements
- Git
- macOS: Xcode Command Line Tools (`xcode-select --install`)
- omarchy: a working omarchy install (ships `yay`)

## Installation

```sh
git clone https://github.com/garbray/vim-config.git ~/workspace/personal/vim-config
cd ~/workspace/personal/vim-config
./install.sh            # packages → link → setup
```

Steps can run on their own: `./install.sh packages|link|setup`.

| Step | macOS | omarchy |
|---|---|---|
| `packages` | Homebrew + [`Brewfile`](./install/macos/Brewfile) | `yay -S --needed` from [`packages.txt`](./install/omarchy/packages.txt) |
| `link` | stow `common` + `macos` | stow `common` |
| `setup` | mise runtimes, oh-my-zsh (+ `chsh` to zsh), git/gh config | same |

`link` moves anything already in the way (e.g. omarchy's LazyVim `~/.config/nvim`) to
`~/.dotfiles-backup/<timestamp>/` before stowing, and drops broken symlinks. Re-running is safe.

Then open a new shell and run `nvim` — lazy.nvim installs plugins, Mason installs
LSPs/formatters, treesitter compiles parsers (`:checkhealth nvim-treesitter`).

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

New config for both OSes goes in `dotfiles/common`, OS-only config in `dotfiles/<os>`.
Packages go in both the Brewfile and `packages.txt`.

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
