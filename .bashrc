# define alias of 'cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# define alias of 'ls'
if ls --color > /dev/null 2>&1
then
    alias ls='ls -la --color=auto'
    export LS_COLORS=''
else
    alias ls='ls -la -G'
    export LSCOLORS=''
fi

# define alias of the other
alias grep='grep --color'
alias df='df -h'
alias ps='ps --sort=start_time'

# load the setting file of git-completion for bash
if [ -f "$HOME/.git-completion.bash" ]
then
    . "$HOME/.git-completion.bash"
else
    printf "WARNING: %s/.git-completion.bash not installed.\\n" "$HOME" 1>&2
fi

# define prompt
if [ -f "$HOME/.git-prompt.sh" ]
then
    . "$HOME/.git-prompt.sh"
    prm_git="\$(__git_ps1)"
else
    printf "WARNING: %s/.git-prompt.sh not installed.\\n" "$HOME" 1>&2
    prm_git="(no git prompt)"
fi

# prompt of date
prm_date="\t"

# prompt of username
prm_un="\
$(if [ "$UID" -eq 0 ]
  then
      printf "\033[1;31;43m"
  else
      printf "\033[36m"
  fi)\
\u\033[0m"

# prompt of hostname
prm_hn="\
$(if [ "$SSH_CONNECTION" ]
  then
      printf "\033[1;32m"
  else
      printf "\033[32m"
  fi)\
\H\033[0m"

# prompt of currect directory
prm_cd="\033[34m\w\033[0m"

# prompt of return code
prm_prompt="\
\$(if [ \$? -eq 0 ]
  then
      printf \"\033[32m\$? \$\033[0m\"
  else
      printf \"\033[31m\$? \$\033[0m\"
  fi)"

PS1="\
<${prm_date}> [${prm_un}@${prm_hn}:${prm_cd}] ${prm_git}\n\
${prm_prompt} "

unset prm_date prm_un prm_hn prm_cd prm_git prm_prompt

