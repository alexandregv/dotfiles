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
  evalcache
  docker
  aws
  heroku
  catimg
  archlinux
  #battery
  tmuxinator
  colored-man-pages
  asdf
  zsh-completions
  jira
  zsh-interactive-cd
  packer
  sudo
  helm
  minikube
)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# SSH agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Completion
fpath=(~/.zsh/completion $fpath)
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit -i
done
compinit -C

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
export EDITOR='nvim'
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
export LOCALE_ARCHIVE=`nix-env --installed --no-name --out-path --query glibc-locales`/lib/locale/locale-archive

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Dart
export PATH="$PATH:/usr/lib/dart/bin:$HOME/.pub-cache/bin"

# NPM
export PATH="$PATH:$HOME/.npm-global/bin"

# Go
export GOPATH="$HOME/go"; [ $at42 = true ] && export GOPATH="$HOME/Documents/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

# nami
export PATH="$PATH:$HOME/.nami/bin"

# rust / cargo
export PATH="$PATH:$HOME/.cargo/bin"

# 42School: PATH
if [ $at42 = true ]; then
	export PATH="$HOME/.brew/bin:$HOME/.local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/munki:$PATH"
fi

# Jira plugin
JIRA_URL="https://42paris.atlassian.net/"
JIRA_NAME="Reach"
JIRA_DEFAULT_ACTION="dashboard"

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
alias gtn='git tag -m $(svu next) $(svu next)'
alias gww='gcc -Wall -Wextra -Werror'
alias vim='nvim'
alias svim='nvim -u ~/.SpaceVim/vimrc'
alias rcl='printf "\ec"'
alias showall='tail -n+1 *'
alias d='docker'
alias dc='docker-compose'
alias dm='docker-machine'
alias k='kubectl'
alias scc="scc --sort code --no-complexity --no-cocomo"

# delete word backward with Ctrl+Delete
bindkey '^H' backward-kill-word

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

# zoxide
eval "$(zoxide init zsh --cmd j)"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# up (ultimate plumber)
zle-upify() {
    buf="$(echo "$BUFFER" | sed 's/[ |]*$//')"
    tmp="$(mktemp)"
    eval "$buf |& up --unsafe-full-throttle -o '$tmp' 2>/dev/null"
    cmd="$(tail -n +2 "$tmp")"
    rm -f "$tmp"
    BUFFER="$BUFFER | $cmd"
    zle end-of-line
}
zle -N zle-upify
bindkey '^P' zle-upify

# atuin (shell history)
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' _atuin_search_widget

# composer
export PATH="$(composer global config bin-dir --absolute --quiet):$PATH"

# enhanced rationalize-dot (expands .... to ../..)
alias ..='cd ..'
function rationalize-dot() {
  if [[ $LBUFFER = '..' ]]; then
    LBUFFER='cd ..'
  fi

  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N rationalize-dot
bindkey '.' rationalize-dot

# keyboard
if xhost >& /dev/null; then
  setxkbmap -layout us -variant altgr-intl
  xmodmap ~/.Xmodmap || true
fi

# python3 binaries from asdf
export PATH="$(asdf where python)/bin:$PATH"

# clean PATH
export PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

# Scaleway CLI autocomplete initialization.
eval "$(scw autocomplete script shell=zsh)"

# krew (kuebctl / k8s plugins manager)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
