# load $HOME/.bashrc.dotold
if [ -f "$HOME/.bashrc.dotold" ]; then
    . "$HOME/.bashrc.dotold"
fi

# define alias of 'cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# define alias of 'ls'
if ls --color > /dev/null 2>&1; then
    alias l='\ls --color=auto'
    alias ll='\ls -l --color=auto'
    alias la='\ls -a --color=auto'
    alias ls='\ls -la --color=auto'
    export LS_COLORS=''
else
    alias l='\ls -G'
    alias ll='\ls -l -G'
    alias la='\ls -a -G'
    alias ls='\ls -la -G'
    export LSCOLORS=''
fi

# define alias of the other
alias grep='grep --color'
alias df='df -h'
alias ps='ps --sort=start_time'

# load the setting script "bash-completion"
if [ -f "$HOME/usr/bash-completion/share/bash-completion/bash_completion" ]; then
    . "$HOME/usr/bash-completion/share/bash-completion/bash_completion"
fi

# load the setting script "git-completion.bash" for bash
if [ -f "$HOME/.git-completion.bash" ]; then
    . "$HOME/.git-completion.bash"
fi

# load the setting script "git-prompt.sh"
if [ -f "$HOME/.git-prompt.sh" ]; then
    . "$HOME/.git-prompt.sh"
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_SHOWCOLORHINTS=true
    GIT_PS1_HIDE_IF_PWD_IGNORED=true
    prm_git="\$(__git_ps1)"
else
    prm_git="(no git-prompt.sh)"
fi

# prompt of username
prm_un="\
\$(if [ \"\$UID\" -eq 0 ]; then
       printf \"\\[\\033[1;31;43m\\]\\u\\[\\033[0m\\]\"
   else
       printf \"\\[\\033[36m\\]\\u\\[\\033[0m\\]\"
   fi)"

# prompt of hostname
prm_hn="\
\$(if [ -z \"\$SSH_TTY\" ]; then
       printf \"\\[\\033[32m\\]\\H\\[\\033[0m\\]\"
   else
       printf \"\\[\\033[1;32m\\]\\H\\[\\033[0m\\]\"
   fi)"

# prompt of currect directory
prm_cd="\
\$(printf \"\\[\\033[34m\\]\\w\\[\\033[0m\\]\" |
   sed -e \"s%/%\\[\\033[1m\\]/\\[\\033[0m\\033[34m\\]%g\")"

# prompt of return code
prm_prompt="\
\$(if [ \$__prm_return_code -eq 0 ]; then
       printf \"\\[\\033[32m\\]\$__prm_return_code \\$\\[\\033[0m\\]\"
   else
       printf \"\\[\\033[31m\\]\$__prm_return_code \\$\\[\\033[0m\\]\"
   fi)"

# get error code of the previous command
PROMPT_COMMAND="__prm_return_code=\$?"

# define primary prompt
PS1="\
[${prm_un}@${prm_hn}:${prm_cd}] ${prm_git}\\n\
${prm_prompt} "

unset prm_un prm_hn prm_cd prm_git prm_prompt

# load $HOME/.bashrc_local
if [ -f "$HOME/.bashrc_local" ]; then
    . "$HOME/.bashrc_local"
fi

