# Vim/Neovim IDE Setup

Personal macOS dev env: Neovim + Tmux + dotfiles, automated install.

## Features
- Neovim IDE: LSP via Mason, blink.cmp completion, Copilot suggestions, Claude Code integration
- Tmux session management via `tmuxSelector`
- Aerospace/yabai tiling, fast nav, hotkeys, minimal mouse
- Full dotfiles, Brewfile + modular install scripts

## Requirements
- macOS (tested on Sonoma+)
- Git
- Xcode Command Line Tools: `xcode-select --install`
- Neovim >= 0.11 (0.12+ recommended; installed by the Brewfile)

## Installation

### 1. Clone
```sh
git clone https://github.com/garbray/vim-config.git ~/workspace/personal/vim-config
cd ~/workspace/personal/vim-config
```

### 2. Install all dependencies
```sh
./install-files/setup.sh
```
Order: Homebrew → taps → `brew bundle` (everything in [`Brewfile`](./Brewfile)) → shell tools → dev tools → Neovim extras → Git/GitHub CLI → env setup.

### 3. Symlink dotfiles
```sh
./install
```
GNU Stow links `.config/*`, plus `.zshrc`, `.tmux.conf` and `tmuxSelector`.

### 4. Reload shell & open Neovim
```sh
source ~/.zshrc
nvim  # lazy.nvim installs plugins, Mason installs LSPs/formatters on first launch
```
First launch also compiles treesitter parsers, which needs the `tree-sitter` CLI (in the Brewfile). Check with `:checkhealth nvim-treesitter`.

## Main Configs
- `dotfiles/.config/nvim/` — Neovim (see below)
- `dotfiles/.zshrc`, `dotfiles/.tmux.conf`, `dotfiles/.config/aerospace/`
- `Brewfile` — all brew/cask packages
- `install-files/` — install scripts
- `.tool-versions` — runtimes managed by [mise](./docs/mise.md)

## Neovim

Lua config on [lazy.nvim](https://github.com/folke/lazy.nvim). One file per concern; every
file under `plugins/` is imported automatically, so adding a plugin means adding one file.

```
dotfiles/.config/nvim/
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

Everything brew-installable lives in [`Brewfile`](./Brewfile) — run `brew bundle` to sync.
Highlights:

- **Editor**: neovim, tree-sitter, efm-langserver, stylua (via cargo)
- **Languages/runtimes**: python, go, lua, luarocks, node, deno, bun, pnpm, openjdk, uv, ninja
- **Runtime versions**: mise, pinned in `.tool-versions`
- **Shell/CLI**: zsh-syntax-highlighting, zsh-autosuggestions, fzf, tmux, ripgrep, eza, z, peco, htop, lazygit, ranger, just, csvlens, trash-cli
- **Window management**: aerospace, yabai, skhd, borders
- **Terminals**: ghostty, kitty
- **Utils**: jq, xh, curlie, ffmpeg, imagemagick, webp, yt-dlp, act, turso, taskwarrior-tui, tidy-html5, ascii-image-converter
- **Apps**: firefox, zen-browser, raycast, numi, keycastr
- **Font**: FiraCode Nerd Font

Not from brew: oh-my-zsh and fzf key bindings (`install_shell_tools.sh`), mise +
`pynvim`/`black`/`flake8` + the `neovim` npm bridge (`install_dev_tools.sh`), stylua
(`install_neovim.sh`). Language servers are **not** installed globally — Mason handles them
inside Neovim.

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
- [tmux/README.md](./tmux/README.md) — tmux usage
- [cursor/config.md](./cursor/config.md) — VSCode/Cursor keybindings
