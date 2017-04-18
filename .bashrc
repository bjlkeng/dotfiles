# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Add coreutils bin dir to path
if [ -d /usr/local/opt/coreutils/libexec ]
then
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# dircolors
# if [ -e ~/.dircolors ]
# then
#   eval `dircolors -b ~/.dircolors`
# fi

if ${use_color} ; then
    PS1='\[\033[01;33m\](\t)\[\033[00m\] \[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
else
    PS1='\t \u@\h \w \$ '
fi


set -o notify           # report the status of completed jobs immediately.
set -o ignoreeof        # dont log out after Ctrl-D.
#set -o xtrace          # useful for debugging scripts!
set -o vi              # bash-style command editing, instead of emacs.
#set -o pipefail        # return right-most non-zero status in a command pipe.

shopt -s checkhash      # check that commands in the hash table still exist.
shopt -s checkwinsize   # keep LINES and COLUMNS up-to-date.

shopt -s extglob        # enable extended pathname completion.
shopt -s cdspell        # expand variables that are directories after 'cd'.
shopt -s no_empty_cmd_completion 2>/dev/null
shopt -s sourcepath     # use PATH to find arguments to source.
shopt -s nocaseglob     # case-insensitive pathname expansion.
shopt -s hostcomplete   # perform hostname completion.

shopt -s cmdhist        # save multi-line commands as single commands in history.
shopt -s histappend     # append to the history file, instead of replacing it.
shopt -s histreedit     # allow failed history substitutions to be re-edited.
shopt -s histverify     # pass history substitutions to the readline buffer before exec.


# Setup some environment variables.
# export EDITOR='nano'
export PAGER='less'
alias more='less'

# # For vim...
export EDITOR='vim'
# export VISUAL='gvim -f'

# Tailor 'less'.
export LESSCHARSET='utf-8'
export LESSOPEN='|lesspipe.sh %s 2>&-'
export LESS='-i -W -x4 -z-4 --no-init -R '

# Tailor ls.
alias l1='/usr/bin/ls -1'       # long format.
alias ls='ls --color=auto -hF'  # color, human-readable sizes, and file-type indicators.
alias l='ls -l'                 # long format.
alias la='ls -A'                # include dot-files.
alias ll='ls -Al'               # long format, w/ dot-files.
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'              # sort by change time.
alias lu='ls -lur'              # sort by access time.  
alias lr='ls -lR'               # recursive ls.
alias lt='ls -ltr'              # sort by date.
alias lm='ls -Al | less'        # pipe through 'more' (i.e., less).

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Tab complete sudo commands
complete -cf sudo

# Figure out how this BASH IT works later...
# # Lock and Load a custom theme file
# # location /.bash_it/themes/
# export BASH_IT_THEME='slick'
# 
# # Set this to false to turn off version control status checking within the prompt for all themes
# export SCM_CHECK=true
# 
# 
# # Load Bash It
# export BASH_IT="$HOME/.bash_it"
# 
# if [ -e $BASH_IT/bash_it.sh ]
# then
#   source $BASH_IT/bash_it.sh
# fi
# 
# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Fix vim colors inside tmux
if [ -n $TMUX ]; then
   alias vim="TERM=screen-256color vim"
fi
