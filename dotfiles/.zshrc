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

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

#another alias we need to move to another file
alias v="nvim"
alias r="ranger"
alias mkd="mkdir -pv"
# alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlight

alias yt="youtube-dl --add-metadata -ic" # Download video link
alias yta="youtube-dl --add-metadata -xic" # download only audio
# alias YT="youtube-viewer"

export EDITOR='nvim'
# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/zsh/gitAlias" ] && source "$HOME/.config/zsh/gitAlias"
# load vim terminal configuration
[ -f "$HOME/.config/zsh/vimconfig" ] && source "$HOME/.config/zsh/vimconfig"

# move to another file
# get wifi pass from the terminal pass the name in double quotes
alias wifiPass="security find-generic-password -wa"
alias listDownloadDB="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select * from LSQuarantineEvent'"
alias clearDownloadDB="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
alias networkEn0="ifconfig en0 | grep inet | awk '{ print $2 }'"
# dig => dns info
# get process number by name
alias processName="ps -ax | grep"
alias flushCache="sudo dscacheutil -flushcache"
alias server="python3 -m http.server 2000"

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
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
#autosuggestions
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#Z config
source /opt/homebrew/etc/profile.d/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# alias python=/usr/local/bin/python3.9
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Go config
export GOPATH=$HOME/.go
export PATH=$PATH:$(go env GOPATH)/bin

# JAVA config
# /usr/libexec/java_home --verbose // provide information of JAVA version current installed
# export JAVA_HOME=$(/usr/libexec/java_home)
# export JDK_8=`/usr/libexec/java_home -v 1.8.0_282`
# export JDK_11=`/usr/libexec/java_home -v 11.0.10`
# export JAVA_HOME=$JDK_8
# export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_282`
# set other java enviroment
# alias java8='export JAVA_HOME=$JDK_8'
# alias java11='export JAVA_HOME=$JDK_11'

# Load localenv variables
[ -f "$HOME/.localenv" ] && source "$HOME/.localenv"

# alias luamake=/Users/bryan.garzon/workspace/lua/lua-language-server/3rd/luamake/compile/luamake
export PATH="$HOME/tools/lua-language-server/bin/macOS:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

source /Users/bryangarzonbahamon/.docker/init-zsh.sh || true # Added by Docker Desktop
