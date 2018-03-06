############################################################
# ALIAS
############################################################
# define alias of 'cd'.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# define alias of 'ls'.
if ls --color > /dev/null 2>&1
then
    colorflag='--color'
    export LS_COLORS=''
else
    colorflag='-G'
    export LSCOLORS=''
fi
alias ls="ls -la $colorflag"
unset colorflag

# define alias of the other.
alias grep='grep --color'
alias df='df -h'
alias ps='ps --sort=start_time'

############################################################
# PROMPT
############################################################
# define primary prompt.
export PS1='[\u@\h \W]\$ '

