############################
#          _               #
#         | |              #
#  _______| |__  _ __ ___  #
# |_  / __| '_ \| '__/ __| #
#  / /\__ \ | | | | | (__  #
# /___|___/_| |_|_|  \___| #
#                          #
############################

# exit if any error# exit if any error
set -e

at42=false

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

if [[ "$TERM" == xterm* ]]; then
	TERM="xterm-256color";
fi
POWERLEVEL9K_MODE="nerdfont-complete"
ZSH_THEME=powerlevel10k/powerlevel10k # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

plugins=(
  git
  docker
  aws
  heroku
  fasd
  catimg
  archlinux
  #battery
  tmuxinator
  colored-man-pages
  asdf
  zsh-completions
)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# SSH agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Homebrew completion
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

	autoload -Uz compinit
	compinit
fi

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
source "$ZSH/oh-my-zsh.sh"

# Replaces os_icon with better colors
POWERLEVEL9K_CUSTOM_ARCH_ICON="echo "
POWERLEVEL9K_CUSTOM_ARCH_ICON_BACKGROUND=069
POWERLEVEL9K_CUSTOM_ARCH_ICON_FOREGROUND=015
# Prompt customization (powerlevel9k)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_arch_icon root_indicator docker_machine aws ssh dir dir_writable vcs) #rvm
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
# Disable correction for hidden files (.ssh) or dot paths (...)
export CORRECT_IGNORE_FILE='.*'
# Multiline prompt prefix
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "
# User icons
POWERLEVEL9K_ROOT_ICON="\uf0e7"
POWERLEVEL9K_USER_ICON="\uf007"
POWERLEVEL9K_SUDO_ICON="\uf09c"

export LANG="en_US.utf8"
export LC_ALL="en_US.utf8"
export LC_COLLATE=C #sort by ASCII
export MYVIMRC="$HOME/.config/nvim/init.vim"
export MYZSHRC="$HOME/.zshrc"
export MYTMUXCONF="$HOME/.config/tmux/tmux.conf"
export CDPATH=".:$HOME:$HOME/Documents"
DEFAULT_USER=aguiot--

# Load ssh keys
find ~/.ssh/ -type f -name '*.priv' -exec ssh-add -q {} +

# 42School: User configuration
if [ $at42 = true ]; then
	DEFAULT_USER=aguiot--
	export MAIL=aguiot--@student.42.fr
fi

# Nix package manager
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi # added by Nix installer
export NIX_PAGER=cat

# Init fasd, more here: https://github.com/clvv/fasd#install
eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
fi


# Preferred web browser
command -v google-chrome-stable &>/dev/null && export BROWSER="google-chrome-stable"

# 42School: Set ScreenSaver to LookThrough
if [ $at42 = true ]; then
	defaults -currentHost write com.apple.screensaver 'CleanExit' -string "YES"
	defaults -currentHost write com.apple.screensaver 'PrefsVersion' -int "100"
	defaults -currentHost write com.apple.screensaver 'idleTime' -int "120"
	defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "moduleName" -string "LookThrough"
	defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "path" -string "$HOME/Library/Screen Savers/LookThrough.saver"
	defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "type" -int "0"
	defaults -currentHost write com.apple.screensaver 'ShowClock' -bool "false"
fi

# cd then ls
function cd() { builtin cd "$*" && ls; }

# 42School: retry
#retry()
#{
#  url=$(git remote get-url origin)
#  nb=${url: -1}
#  if ! [[ $nb =~ '^[0-9]+$' ]]; then
#	  git remote set-url origin $url"2"
#  else
#	  url=$(echo $url | rev | cut -c 2- | rev)
#	  git remote set-url origin $url$((nb+1))
#  fi
#  echo "New remote URL: $(git remote get-url origin)\n(lol u retried, u noob)"
#}

# docker
undock() { eval "$(docker-machine env -u)"; }
dock()   { undock; eval "$(docker-machine env "$1")"; }
alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'

# Aliases
alias cls='clear && ls'
alias cl='clear'
alias gl='git --no-pager log -n 10 --graph --decorate --oneline --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %Cgreen(%cr)%Creset %C(yellow)(%an%C(yellow))%Creset %s %Creset'\'
alias gll='git --no-pager log --graph --decorate --oneline --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %Cgreen(%cr)%Creset %C(yellow)(%an%C(yellow))%Creset %s %Creset'\'
alias gs='git status -unormal'
alias gsa='git status -uall'
alias gcm='git commit -m'
alias gww='gcc -Wall -Wextra -Werror'
alias vim='nvim'
alias svim='nvim -u ~/.SpaceVim/vimrc'
alias rcl='printf "\ec"'
alias showall='tail -n+1 *'
alias pyg='pygmentize -g'
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'
alias j='fasd_cd -d'
alias gdc='gd --cached'
alias norminette='~/.norminette/norminette.rb'
alias scc="scc --sort code --no-complexity --no-cocomo"

unalias gcl;
function gcl() {
	git clone --recurse-submodules "$@"
	echo ""
	if [[ -n "$2" ]]; then
		cd "$2"
	else
		cd "$(basename "$1" .git)"
	fi
}

if [ $at42 = true ]; then
	alias 42clean='rm -f ~/.zcompdump*; rm -rf ~/.cache; rm -rf ~/Library/Caches; brew cleanup'
	alias 42FC='bash ~/Documents/Tools/42FileChecker/42FileChecker.sh'
	alias RP42='open /sgoinfre/goinfre/Perso/aguiot--/public/RP42.app'

	# 42toolbox (https://github.com/alexandregv/42toolbox)
	# Alias format: tb + script first letter
	alias tbs="$HOME/42toolbox/init_session.sh"
	alias tbd="$HOME/42toolbox/init_docker.sh"

	# valgrind macOS
	function valgrind_make ()   { docker run --workdir "$HOME" --entrypoint sh -v "$PWD:$HOME" mooreryan/valgrind -c "make && valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all --show-reachable=yes $*"; }
	function valgrind_custom () { docker run --workdir "$HOME" --entrypoint sh -v "$PWD:$HOME" mooreryan/valgrind -c "$1 && valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all --show-reachable=yes $2"; }
	alias valgrind='valgrind_make'
fi

# Dart
export PATH="$PATH:/usr/lib/dart/bin:$HOME/.pub-cache/bin"

# NPM
export PATH="$PATH:$HOME/.npm-global/bin/"

# Go
export GOPATH="$HOME/go"; [ $at42 = true ] && export GOPATH="$HOME/Documents/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOPATH/bin"

# nami
export PATH="$PATH:$HOME/.nami/bin"

# rust / cargo
export PATH="$PATH:$HOME/.cargo/bin"

# 42School: PATH
if [ $at42 = true ]; then
	export PATH="$HOME/.brew/bin:$HOME/.local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/munki:$HOME/.local/bin:$PATH"
fi

# tmux
bindkey -r "^[a" # change "replace-and-hold to null
if command -v tmux &> /dev/null && [ -z "$TMUX" ] && (tmux ls -F '#{session_attached}' | (! grep -q '1')); then
	tmux attach -t default || tmux new -s default
fi

if [ -e "$XDG_CONFIG_HOME/tmux/tmuxinator.zsh" ]; then
	source "$XDG_CONFIG_HOME/tmux/tmuxinator.zsh"
fi

# asdf version manager
if [ $at42 = true ]; then
    . "$(brew --prefix asdf)/asdf.sh"
fi

# direnv
eval "$(direnv hook zsh)"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# keyboard
setxkbmap -layout us -variant intl
xmodmap ~/.Xmodmap || true
