# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# PS1='\w$ '
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# remainder added by bbawn

function agl {
  ag --hidden --color "$@" | less -R
}

function afl {
  ag --hidden --ignore '/test' --ignore '*_test.go' --ignore 'mock' --ignore mocks --color "$@" | less -R
}

function randpw {
  openssl rand -base64 32
}

# Focused search
alias af="ag --ignore '/test' --ignore '*_test.go' --ignore 'mock' --ignore mocks"

alias agh="ag --hidden"


alias dc="docker compose"

alias gb="git branch"
alias gs="git status"
alias gco="git checkout"

alias dcci='docker-compose --file docker-compose.ci.yml'

alias gbb="cd ~/go/src/github.com/bbawn" 

# append to history file after each command
# XXX this doesn't seem to work the way I expect
export PROMPT_COMMAND='history -a'

export EDITOR='vim'

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/bin
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)

# Jupyter needs this for some reason
export BROWSER=google-chrome

export GITHUB_ACCESS_TOKEN=df2d3c4185474b438e686e8fbd77fcdafbc1ce5f

export PATH=$PATH:/$(brew --prefix)/opt/python/libexec/bin

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
