# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# deactivate magic functions
export DISABLE_MAGIC_FUNCTIONS=true

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="half-life"
ZSH_THEME="af-magic"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
bindkey -s '^k' 'clear\n'

autoload autosuggest-excute; zle -N autosuggest-excute
bindkey '^\' autosuggest-excute
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999,bg=cyan,bold,underline"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/zsh/gitAlias" ] && source "$HOME/.config/zsh/gitAlias"
# load vim terminal configuration
[ -f "$HOME/.config/zsh/vimconfig" ] && source "$HOME/.config/zsh/vimconfig"
# load personal aliases
[ -f "$HOME/.config/zsh/personalAlias" ] && source "$HOME/.config/zsh/personalAlias"

export EDITOR='nvim'

# basic auto/tab complete
# autoload -U componit
# zstyle ':completion:*' menu select
# zmodload zsh/complist
# compinit
_comp_options+=(globdots)

# =============== terminal colors ========================

export RS="\033[0m"    # reset
export HC="\033[1m"    # hicolor
export UL="\033[4m"    # underline
export INV="\033[7m"   # inverse background and foreground
export FBLK="\033[30m" # foreground black
export FRED="\033[31m" # foreground red
export FGRN="\033[32m" # foreground green
export FYEL="\033[33m" # foreground yellow

# fix locale issue on kitty terminal
export LANG="en_US.UTF-8"

export BAT_THEME="gruvbox"

# =============== shell plugins ========================

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/etc/profile.d/z.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =============== runtime versions (mise) ========================
# replaces: volta, nvm, pyenv
eval "$($HOME/.local/bin/mise activate zsh)"

# =============== language paths ========================

# Go
export GOPATH=$HOME/.go
export PATH=$PATH:$(go env GOPATH)/bin

# Java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# postgres client
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# =============== tools ========================

export TASKRC="$HOME/.config/task-warrior/.taskrc"
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"
export PATH="$HOME/.orbit/bin:$PATH"

alias lg="lazygit"

# Load localenv variables
[ -f "$HOME/.localenv" ] && source "$HOME/.localenv"

# Google Cloud SDK
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"; fi
