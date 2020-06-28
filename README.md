# Vim as IDE

Lately I have decided to use vim as my main IDE some of the points for it are:

- vim is lightweight
- persistent session management with tmux just works
- efficient workflow navigation using hotkeys
- use less your mouse
- intellisense with [Coc](https://github.com/neoclide/coc.nvim)

## Vim configuration and commands

Here is my vim setup and the configurations I found best suite for me.

## Dependencies

To make vim works really great in macOSX you can use the following thirdparties to improve his performance

- brew
- cask
- kitty term
- Plug
- highlight
- ripgrep
- coc

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

### Plug

is a minimalist vim plugin install [site](https://github.com/junegunn/vim-plug)

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Highlight

Display the previsualizer with the color syntaxis

```
brew install highlight
```

### ripgrep

a faster search tahn grep

```
brew install ripgrep
```

### Python3

In the case you decide to use `nvim` and use Coc as your intellisense plugin you should install

```
python3 -m pip install --user --upgrade pynvim
```

## Other resoureces

Tmux basic usage

[tmux](./tmux.md)

CheatSheet

[cheatsheet vim](./cheatsheet-vim.md)

Search inside vim project

[link search example](https://stackoverflow.com/questions/7950558/how-can-i-search-a-word-in-whole-project-folder-recursively)

Nice talk about the usage of vim as a IDE
[talk](https://www.youtube.com/watch?v=E-ZbrtoSuzw)
[commands](https://www.keycdn.com/blog/vim-commands)
