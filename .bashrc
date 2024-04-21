#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

source "$HOME/.config/env"
export HISTFILE="$XDG_STATE_HOME/bash/history"

shopt -s extglob failglob
source "$HOME/.config/aliasrc"

# autojump
[[ -s /usr/share/autojump/autojump.bash ]] && source /usr/share/autojump/autojump.bash
export PATH="$HOME/opt/cross/bin:$PATH"
export PATH="$PATH:/opt/010editor" #ADDED BY 010 EDITOR

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

