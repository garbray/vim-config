# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/bryan.garzon/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# git alias
alias gp="git pull"
alias gps="git push"
alias gpd="git pull develop"
alias gck="git checkout"
alias gr="git rebase"
alias grm="git rebase master"
alias gd="git diff"
alias gc="git commit"
alias gli="git log --oneline"
alias gca="git commit --amend"
alias glg="git log --oneline --graph"
#alias gsoft="git reset --soft $(git merge-base origin/master Head)"
alias grh="git reset head --hard"
alias grs="git reset head --soft"

function gsoft() {
  git reset --soft $(git merge-base origin/master Head)
}

alias copyPath="pwd | pbcopy"

export JAVA_HOME=$(/usr/libexec/java_home)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

export TM_AACU=/Users/bryan.garzon/workspace/ticketmaster/accounts-archtics-consolidate-user-webapp
export TM_AACU_UI=/Users/bryan.garzon/workspace/ticketmaster/accounts-archtics-consolidate-user-webapp/accounts-archtics-consolidate-user-webapp-ui
export TM_WEBCOMMON=/Users/bryan.garzon/workspace/ticketmaster/webapp-common-ui
alias mvni="$TM_AACU && mvn clean install"
alias initSpring="$TM_AACU && cd accounts-archtics-consolidate-user-webapp-main && mvn spring-boot:run"

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

# alias npm
alias yt="yarn test"
alias ytw="yarn test --watch"
alias ytwc="yarn test --watch --coverage"
alias ys="yarn start"
alias yb="yarn build"

alias init_nvim="nvim ~/.config/nvim/init.vim"

alias tmuxWeb="~/tmux-web.sh webDev"

# fix locale issue on kitty terminal
export LANG="en_US.UTF-8"