# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Path to your oh-my-zsh installation.
export ZSH="/Users/bryan.garzon/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="af-magic"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
bindkey -s '^k' 'clear\n'

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/zsh/gitAlias" ] && source "$HOME/.config/zsh/gitAlias"
# basic auto/tab complete
# autoload -U componit
# zstyle ':completion:*' menu select
# zmodload zsh/complist
# compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# =============== terminal colors ========================

export RS="\033[0m"    # reset
export HC="\033[1m"    # hicolor
export UL="\033[4m"    # underline
export INV="\033[7m"   # inverse background and foreground
export FBLK="\033[30m" # foreground black
export FRED="\033[31m" # foreground red
export FGRN="\033[32m" # foreground green
export FYEL="\033[33m" # foreground yellow

# ========== livenation - accounts - AACU ================

export TM_AACU=~/workspace/ticketmaster/modern-accounts/accounts-archtics-consolidate-user-webapp
export TM_AACU_UI=~/workspace/ticketmaster/modern-accounts/accounts-archtics-consolidate-user-webapp/accounts-archtics-consolidate-user-webapp-ui
export TM_WEBCOMMON=~/workspace/ticketmaster/modern-accounts/webapp-common-ui
alias mvni="$TM_AACU && mvn clean install"
alias initSpring="$TM_AACU && cd accounts-archtics-consolidate-user-webapp-main && mvn spring-boot:run"
alias runSpring="mvn clean install -Dmaven.test.skip=true spring-boot:run"

function copyTmWebcommon() {
  myvar="$PWD"
  echo 'running yarn build'
  $TM_WEBCOMMON && yarn build
  echo 'yarn build completed'
  echo 'copying dist files'
  cp $TM_WEBCOMMON/dist/* $TM_AACU_UI/node_modules/webapp-common-ui/dist/
  echo -e "$FGRN UPDATED NEW VERSION ON NODE_MODULES"
  echo -e "$FYEL ====DONT FORGET TO ROLLBACK YOUR CHANGES AFTER YOU ARE DONE===="
  cd "$myvar"
}

function revertTmWebcommon() {
  echo 'reverting webapp-common-ui'
  rm $TM_AACU_UI/node_modules/webapp-common-ui/dist/
  cd $TM_AACU_UI
  yarn
  echo "you should get back to the previous version"
}

# fix locale issue on kitty terminal
export LANG="en_US.UTF-8"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export BAT_THEME="gruvbox"

# lf complements
# LFCD="$GOPATH/src/github.com/gokcehan/lf/etc/lfcd.sh"  # source
# LFCD="/path/to/lfcd.sh"                                #  pre-built binary, make sure to use absolute path
# if [ -f "$LFCD" ]; then
#     source "$LFCD"
# fi

# bindkey '^o' "lfcd\n"

#highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias python=/usr/local/bin/python3.9
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_282`


