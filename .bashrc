# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# some more aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# function for connecting to a host via ssh
ssh_kyle () { ssh "kyle_connelly@$@.biarrinetworks.com"; }

export WORKON_HOME=~/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

export GUROBI_650_HOME="/opt/gurobi650/linux64"
export GUROBI_700_HOME="/opt/gurobi700/linux64"
export GUROBI_810_HOME="/opt/gurobi810/linux64"
export PATH="${PATH}${PATH:+:}${GUROBI_650_HOME}/bin:${GUROBI_700_HOME}/bin:${GUROBI_810_HOME}/bin"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}${LD_LIBRARY_PATH:+:}${GUROBI_650_HOME}/lib:${GUROBI_700_HOME}/lib:${GUROBI_810_HOME}/lib"
export CXXFLAGS='-std=c++11'
export VISUAL="subl -w"
export EDITOR="subl -w"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# v4l2-ctl --set-fmt-video=width=1280,height=720,pixelformat='YUYV'

# remap keys with xmodmap
xmodmap ~/.Xmodmap

git_branch() {
git branch 2> /dev/null | awk '/\*/ { printf $2 }'
}

Black=$'\e[0;30m'
Red=$'\e[0;31m'
Green=$'\e[0;32m'
Brown=$'\e[0;33m'
Blue=$'\e[0;34m'
Purple=$'\e[0;35m'
Cyan=$'\e[0;36m'
LGray=$'\e[0;37m'
DGray=$'\e[1;30m'
LRed=$'\e[1;31m'
LGreen=$'\e[1;32m'
Yellow=$'\e[1;33m'
LBlue=$'\e[1;34m'
LPurple=$'\e[1;35m'
LCyan=$'\e[1;36m'
White=$'\e[1;37m'

export PS1_default='${Cyan}\u@\h ${LGray}in ${Green}\w ${LGray}on ${Brown}$(git_branch)${LGray} @ ${DGray}\t${LGray}\n$ '
export PS1_train='${Cyan}\u@\h ${LGray}on ${Brown}$(git_branch)${LGray} @ ${DGray}\t${LGray}\n$ '
alias ps1_default="export PS1="\$PS1_default""
alias ps1_train="export PS1="\$PS1_train""
ps1_default

# [[ $TERM != "screen-256color" ]] && exec tmuxp load path/to/yaml/files

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
