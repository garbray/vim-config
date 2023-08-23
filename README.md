# Vim as IDE

Lately, I have decided to use vim as my main IDE some points for it are:

- vim is lightweight
- persistent session management with Tmux just works
- efficient workflow navigation using hotkeys
- use less your mouse
- Intellisense with LSP (build in on Neovim)

## TODO list

- [ ] create installation script
- [ ] use ansible
- [x] move to use Lua

## Vim configuration and commands

Here is my vim setup and the configurations I found best suite for me.

## Dependencies

To make vim works great in macOSX you can use the following third parties to improve his performance

- brew
- cask
- kitty term
- Plug
- highlight
- ripgrep

### brew install

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### cask

here are all the cask [formulas](https://github.com/neoclide/coc.nvim)

### kitty term

```
brew cask install kitty
```

if you are an `ohmyzsh` user to fix the autocomplete feature in kitty you should run

> export LANG="en_US.UTF-8"

### Plug

is a minimalist vim plugin install [site](https://github.com/junegunn/vim-plug)

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Highlight

Display the pre visualizer with the color syntaxis

```
brew install highlight
```

### ripgrep

a faster search than grep

```
brew install ripgrep
```

### Python3

In the case, you decide to use `nvim` and use Coc as your intellisense plugin you should install

```
python3 -m pip install --user --upgrade pynvim
```

## Other resources

Tmux basic usage

[tmux](./tmux/README.md)

CheatSheet

[cheatsheet vim](./cheatsheet-vim.md)

Search inside vim project

[link search example](https://stackoverflow.com/questions/7950558/how-can-i-search-a-word-in-whole-project-folder-recursively)

Nice talk about the usage of vim as a IDE
[talk](https://www.youtube.com/watch?v=E-ZbrtoSuzw)
[commands](https://www.keycdn.com/blog/vim-commands)

```
chmod +x backup
```

# multiple gh accounts

add a new ssh

```
ssh-keygen -t rsa -b 4096 -C "youremail"

```

in the ssh folder create a config file with the following

```
# Defauilt Github
Host work
    HostName github.com
    AddKeysToAgent yes
    User git
    IdentityFile ~/.ssh/id_rsa

Host alias
    HostName github.com
    AddKeysToAgent yes
    User git
    IdentityFile ~/.ssh/id_rsa_another

```

ssh-add path-to-ssh-key

test your ssh

```
ssh -T youralias
```

testing word adding
