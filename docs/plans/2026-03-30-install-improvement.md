# Install Process Improvement Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use executing-plans to implement this plan task-by-task.

**Goal:** Rewrite `install` as a smart single entry point that auto-detects fresh vs re-run, shows a menu on re-run, and makes all sub-scripts idempotent.

**Architecture:** `install` detects state via `command -v brew` and `[ -L ~/.zshrc ]`, then calls `install-files/setup.sh` for tools and/or runs stow/symlinks for dotfiles. Each sub-script gets guards around non-idempotent operations.

**Tech Stack:** bash, GNU stow, brew bundle

---

### Task 1: Fix symlink handling in `install`

**Files:**
- Modify: `install`

**Step 1: Replace broken stow conditional**

Current (buggy — never stows on fresh install):
```bash
if [ ! -d $HOME/.config/ ]; then
    mkdir $HOME/.config
else
    stow -t $HOME/.config -D .
fi
stow -t $HOME/.config -d dotfiles .config
```

Replace with:
```bash
mkdir -p "$HOME/.config"
stow --restow -t "$HOME/.config" -d dotfiles .config
```

**Step 2: Replace `rm + ln -s` with `ln -sf`**

Replace:
```bash
rm ~/.tmux.conf
ln -s $repoPath/dotfiles/.tmux.conf ~/.tmux.conf

rm ~/.zshrc
ln -s $repoPath/dotfiles/.zshrc ~/.zshrc

rm ~/tmuxSelector
ln -s $repoPath/tmuxSelector ~/tmuxSelector
```

With:
```bash
ln -sf "$repoPath/dotfiles/.tmux.conf" ~/.tmux.conf
ln -sf "$repoPath/dotfiles/.zshrc" ~/.zshrc
ln -sf "$repoPath/tmuxSelector" ~/tmuxSelector
```

**Step 3: Fix `/usr/local/bin` conditional (same bug pattern)**

Replace:
```bash
if [ ! -d /usr/local/bin/ ]; then
    mkdir /usr/local/bin
else
    rm /usr/local/bin/projectSelector
fi
sudo ln -s $repoPath/tmuxSelector /usr/local/bin/projectSelector
```

With:
```bash
sudo mkdir -p /usr/local/bin
sudo ln -sf "$repoPath/tmuxSelector" /usr/local/bin/projectSelector
```

**Step 4: Verify syntax**

```bash
bash -n install
```
Expected: no output (clean)

**Step 5: Commit**

```bash
git add install
git commit -m "fix(install): use ln -sf and stow --restow for idempotent symlinks"
```

---

### Task 2: Add detection logic and menu to `install`

**Files:**
- Modify: `install`

**Step 1: Wrap dotfile logic into a function**

Extract the stow + symlink block into a function at the top of `install`:

```bash
#!/usr/bin/env bash
set -e
repoPath="$PWD"

link_dotfiles() {
    mkdir -p "$HOME/.config"
    stow --restow -t "$HOME/.config" -d dotfiles .config
    ln -sf "$repoPath/dotfiles/.tmux.conf" ~/.tmux.conf
    ln -sf "$repoPath/dotfiles/.zshrc" ~/.zshrc
    ln -sf "$repoPath/tmuxSelector" ~/tmuxSelector
    sudo mkdir -p /usr/local/bin
    sudo ln -sf "$repoPath/tmuxSelector" /usr/local/bin/projectSelector
}

install_tools() {
    sh "$(dirname "$0")/install-files/setup.sh"
}
```

**Step 2: Add detection and menu logic**

Append after the functions:

```bash
HAS_BREW=false
HAS_DOTFILES=false
command -v brew &>/dev/null && HAS_BREW=true
[ -L "$HOME/.zshrc" ] && HAS_DOTFILES=true

if ! $HAS_BREW && ! $HAS_DOTFILES; then
    echo "Fresh install detected — running full setup..."
    install_tools
    link_dotfiles
elif $HAS_BREW && ! $HAS_DOTFILES; then
    echo "Tools already installed — linking dotfiles..."
    link_dotfiles
elif ! $HAS_BREW && $HAS_DOTFILES; then
    echo "Dotfiles already linked — installing tools..."
    install_tools
else
    echo "What would you like to do?"
    echo "  1) Dotfiles only"
    echo "  2) Tools only"
    echo "  3) Both [default]"
    read -r choice
    choice="${choice:-3}"
    case "$choice" in
        1) link_dotfiles ;;
        2) install_tools ;;
        *) install_tools && link_dotfiles ;;
    esac
fi

echo "Done!"
```

**Step 3: Verify syntax**

```bash
bash -n install
```
Expected: no output

**Step 4: Commit**

```bash
git add install
git commit -m "feat(install): smart entry point with fresh-install detection and re-run menu"
```

---

### Task 3: Make `install_shell_tools.sh` idempotent

**Files:**
- Modify: `install-files/install_shell_tools.sh`

**Step 1: Guard oh-my-zsh install**

Replace:
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

With:
```bash
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "oh-my-zsh already installed, skipping."
fi
```

Note: `--unattended` prevents the installer from switching your shell interactively (safe for re-runs and CI).

**Step 2: Verify syntax**

```bash
bash -n install-files/install_shell_tools.sh
```
Expected: no output

**Step 3: Commit**

```bash
git add install-files/install_shell_tools.sh
git commit -m "fix(install): guard oh-my-zsh install for idempotency"
```

---

### Task 4: Make `install_dev_tools.sh` idempotent

**Files:**
- Modify: `install-files/install_dev_tools.sh`

**Step 1: Guard mise install**

Replace:
```bash
curl https://mise.run | sh
mise install
```

With:
```bash
if ! command -v mise &>/dev/null; then
    curl https://mise.run | sh
fi
mise install
```

**Step 2: Guard pip installs**

Replace:
```bash
python3 -m pip install --user --upgrade pynvim
pip install black flake8
```

With:
```bash
python3 -m pip install --user --upgrade pynvim
pip install --upgrade black flake8
```

Note: `pip install --upgrade` is already idempotent (upgrades if newer, no-ops if current).

**Step 3: Guard npm global install**

Replace:
```bash
npm install -g neovim
```

With:
```bash
npm list -g neovim --depth=0 &>/dev/null || npm install -g neovim
```

**Step 4: Verify syntax**

```bash
bash -n install-files/install_dev_tools.sh
```
Expected: no output

**Step 5: Commit**

```bash
git add install-files/install_dev_tools.sh
git commit -m "fix(install): guard mise and npm installs for idempotency"
```

---

### Task 5: Make `install_neovim.sh` idempotent

**Files:**
- Modify: `install-files/install_neovim.sh`

**Step 1: Guard stylua**

Replace:
```bash
cargo install stylua
```

With:
```bash
command -v stylua &>/dev/null || cargo install stylua
```

**Step 2: Verify syntax**

```bash
bash -n install-files/install_neovim.sh
```
Expected: no output

**Step 3: Commit**

```bash
git add install-files/install_neovim.sh
git commit -m "fix(install): guard stylua install for idempotency"
```

---

### Task 6: Make `install_git_tools.sh` idempotent

**Files:**
- Modify: `install-files/install_git_tools.sh`

**Step 1: Guard gh alias creation**

Replace:
```bash
gh alias set personal '!cp ~/.config/gh/hosts.yml.personal ~/.config/gh/hosts.yml && gh auth status'
gh alias set work '!cp ~/.config/gh/hosts.yml.work ~/.config/gh/hosts.yml && gh auth status'
```

With:
```bash
gh alias list | grep -q "^personal" || \
    gh alias set personal '!cp ~/.config/gh/hosts.yml.personal ~/.config/gh/hosts.yml && gh auth status'
gh alias list | grep -q "^work" || \
    gh alias set work '!cp ~/.config/gh/hosts.yml.work ~/.config/gh/hosts.yml && gh auth status'
```

Note: `git config --global` calls are already idempotent (overwrite is safe).

**Step 2: Verify syntax**

```bash
bash -n install-files/install_git_tools.sh
```
Expected: no output

**Step 3: Commit**

```bash
git add install-files/install_git_tools.sh
git commit -m "fix(install): guard gh alias creation for idempotency"
```

---

## Unresolved Questions

- Should `--unattended` for oh-my-zsh suppress the default shell change prompt on all macOS versions?
- Is `/usr/local/bin` the right path on Apple Silicon (vs `/opt/homebrew/bin`)?
