# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -la --color=auto'
PS1='[\u@\h \W]\$ '

PATH=${HOME}/usr/dropbox/bin:${PATH}
PATH=${HOME}/usr/texlive/2017/bin/x86_64-linux:${PATH}

