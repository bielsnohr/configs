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
    screen) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

HOST_SHRT=`hostname | sed s/$USER-//`
if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@$HOST_SHRT\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@$HOST_SHRT:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@$HOST_SHRT: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# Set screen prompt
if [ -n $STY ]; then
    export PS1=$PS1
fi

# Source pureline for a better prompt than the above
if [ "$TERM" != "linux" ]; then
    source ~/pureline/pureline ~/.pureline.conf
fi

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias lt='ls -ltr'
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

# Modify executable path variable for personal binaries
PEACOCK="$HOME/work/projects/moose_fi_app/code/moose/python/peacock"
PARAVIEW="$HOME/Applications/ParaView-5.9.0-MPI-Linux-Python3.8-64bit/bin"
export PATH="$HOME/bin:$HOME/Applications/adb-fastboot:$PEACOCK:$PARAVIEW:$HOME/.local/bin:$PATH" 

# Set preferred editing mode and editor
set -o vi
export EDITOR="gvim -f"

# Python startup
export PYTHONSTARTUP="$HOME/.pystartup"
#export PYTHONPATH="$HOME/adas/python:/home/adas/python"

# Java setup for PaperScope
export JAVA_HOME="/usr/bin/java"

# HTTP(S) and Subversion Proxy Settings
# No longer needed as of 2015-10-26 because CCFE removed proxy
#source "$HOME/bin/http_proxy.sh"
#source "$HOME/bin/svn_proxy.sh"

# Set Latex environment variables for compliance with ADAS referencing
export TEXINPUTS="$TEXINPUTS:.:$HOME/svn_adas/resources/latex//:$HOME/\
workspace/phd-strath/papers/thesis/glossary//"
export BIBINPUTS=":.:$HOME/svn_adas/resources/latex//:$HOME/\
workspace/resources/zotero_bibtex//"
export BSTINPUTS=":.:$HOME/svn_adas/resources/latex//"

# Set CVS_RSH
export CVS_RSH="/usr/bin/ssh"

# ADAS setup
if [ -f /home/adas/setup/adas_setup.ksh ]; then
    . /home/adas/setup/adas_setup.ksh
fi

# Allow forward and recursive-i-search
stty -ixon

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mbluteau/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mbluteau/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/mbluteau/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mbluteau/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

. "$HOME/.cargo/env"
