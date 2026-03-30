# Install Process Improvement Design

## Goals

- Fix fresh-machine errors (broken stow conditional, `rm` failures)
- Make all scripts safe to re-run (idempotent)
- Single entry point that auto-detects fresh vs existing install

## Entry Point & Detection

`install` is the single entry point. It checks two signals at startup:

- `command -v brew` → tools installed
- `[ -L ~/.zshrc ]` → dotfiles symlinked

| brew | dotfiles | behavior |
|------|----------|----------|
| no   | no       | fresh → run tools then dotfiles, no prompt |
| yes  | yes      | re-run → show menu (default: 3-Both) |
| yes  | no       | run dotfiles only |
| no   | yes      | run tools only |

Re-run menu:
```
What would you like to do?
  1) Dotfiles only
  2) Tools only
  3) Both [default]
```

## Idempotency Fixes

### install (dotfiles)
- Replace `rm + ln -s` with `ln -sf` for `.zshrc`, `.tmux.conf`, `tmuxSelector`
- Replace broken stow conditional with `stow --restow -t $HOME/.config -d dotfiles .config`

### install_shell_tools.sh
- Guard oh-my-zsh: `[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl ...)"`

### install_dev_tools.sh
- Guard mise: `command -v mise || curl https://mise.run | sh`
- Guard npm global: `npm list -g neovim | grep -q neovim || npm install -g neovim`

### install_neovim.sh
- Guard stylua: `command -v stylua || cargo install stylua`

### install_git_tools.sh
- Guard gh aliases: `gh alias list | grep -q personal || gh alias set personal ...`
- git config calls are already idempotent

### setup_env.sh
- Already idempotent (`mkdir -p`, `touch`)

## Flow

```
install
├── detect state
├── fresh → setup.sh + stow/symlinks
├── partial → skip done steps
└── re-run → menu → setup.sh and/or stow/symlinks
```

`setup.sh` stays as the tools orchestrator, unchanged structurally.
