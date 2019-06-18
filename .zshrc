############################
#          _               #
#         | |              #
#  _______| |__  _ __ ___  #
# |_  / __| '_ \| '__/ __| #
#  / /\__ \ | | | | | (__  #
# /___|___/_| |_|_|  \___| #
#                          #
############################

at42=false

if [ $at42 = true ]; then
	HOME="/Users/aguiot--"
else
	HOME="/home/aguiot"
fi

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

#export TERM="xterm-256color"
POWERLEVEL9K_MODE="nerdfont-complete"
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(
  git
  docker
  aws
  heroku
  autojump
  catimg
  archlinux
  #battery
  tmuxinator
)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
source $ZSH/oh-my-zsh.sh

# Replaces os_icon with better colors
POWERLEVEL9K_CUSTOM_ARCH_ICON="echo "
POWERLEVEL9K_CUSTOM_ARCH_ICON_BACKGROUND=069
POWERLEVEL9K_CUSTOM_ARCH_ICON_FOREGROUND=015
# Prompt customization (powerlevel9k)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_arch_icon root_indicator docker_machine aws ssh user dir dir_writable vcs rvm)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs disk_usage time ram command_execution_time) #battery_pct_prompt 
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
# Disk usage
POWERLEVEL9K_DISK_USAGE_ONLY_WARNING=true
POWERLEVEL9K_DISK_USAGE_WARNING_LEVEL=50
POWERLEVEL9K_DISK_USAGE_CRITICAL_LEVEL=65
# Time
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
# Autocorrect commands
ENABLE_CORRECTION="true"
setopt correct_all
# Multiline prompt prefix
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "
# User icons
POWERLEVEL9K_ROOT_ICON="\uf0e7"
POWERLEVEL9K_USER_ICON="\uf007"
POWERLEVEL9K_SUDO_ICON="\uf09c"

export LANG=en_US.UTF-8
export LC_COLLATE=C #sort by ASCII
export MYVIMRC="$HOME/.config/nvim/init.vim"
export MYZSHRC="$HOME/.zshrc"
export MYTMUXCONF="$HOME/.config/tmux/tmux.conf"
DEFAULT_USER=aguiot

# 42School: User configuration
if [ $at42 = true ]; then
	DEFAULT_USER=aguiot--
	export MAIL=aguiot--@student.42.fr
fi

eval "$(fasd --init auto)"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# 42School: Set ScreenSaver to LookThrough
if [ $at42 = true ]; then
	defaults -currentHost write com.apple.screensaver 'CleanExit' -string "YES"
	defaults -currentHost write com.apple.screensaver 'PrefsVersion' -int "100"
	defaults -currentHost write com.apple.screensaver 'idleTime' -int "120"
	defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "moduleName" -string "LookThrough"
	defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "path" -string "/Users/aguiot--/Library/Screen Savers/LookThrough.saver"
	defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "type" -int "0"
	defaults -currentHost write com.apple.screensaver 'ShowClock' -bool "false"
fi

# cd then ls
function cd() { builtin cd "$*" && ls; }

# 42School: retry
retry()
{
  url=$(git remote get-url origin)
  nb=${url: -1}
  if ! [[ $nb =~ '^[0-9]+$' ]]; then
	  git remote set-url origin $url"2"
  else
	  url=$(echo $url | rev | cut -c 2- | rev)
	  git remote set-url origin $url$((nb+1))
  fi
  echo "New remote URL: $(git remote get-url origin)\n(lol u retried, u noob)"
}

# docker
undock() { eval $(docker-machine env -u) }
dock()   { undock; eval $(docker-machine env $1) }

# Aliases
alias cls="clear && ls"
alias cl="clear"
alias gl="git --no-pager log --graph --decorate --oneline"
alias gs="git status -unormal"
alias gsa="git status -uall"
alias gcm="git commit -m"
alias gww="gcc -Wall -Wextra -Werror"
alias 42FC="bash ~/Documents/42FileChecker/42FileChecker.sh"
alias imgcat="~/imgcat.sh $1"
alias vim="nvim"
alias svim="nvim -u ~/.SpaceVim/vimrc"
alias rcl='printf "\ec"'
alias showall='tail -n+1 *'
alias pyg='pygmentize -g'
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'

# Dart
export PATH="$PATH:/usr/lib/dart/bin:$HOME/.pub-cache/bin"

# NPM
export PATH="$PATH:$HOME/.npm-global/bin/"

# 42School: PATH
if [ $at42 = true ]; then
	export PATH="$PATH:/Users/aguiot--/.brew/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/munki"
fi

# tmux
bindkey -r "^[a" # change "replace-and-hold to null
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
source $XDG_CONFIG_HOME/tmux/tmuxinator.zsh

# asdf version manager
source /opt/asdf-vm/asdf.sh
source /opt/asdf-vm/completions/asdf.bash

# Source RVM scripts
#source $HOME/.rvm/scripts/rvm
# RVM bash completion
#[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"
