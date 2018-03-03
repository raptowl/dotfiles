# define alias.
alias ls='ls -la --color=auto'
alias grep='grep --color'
alias df='df -h'
alias ps='ps --sort=start_time'

# define variables.
PS1='[\u@\h \W]\$ '
PATH=${DOTPATH}/bin:${PATH}
PATH=${HOME}/usr/dropbox/bin:${PATH}
PATH=${HOME}/usr/texlive/2017/bin/x86_64-linux:${PATH}

