#!/bin/sh

# ANSI Escape Sequence
AES_reset="\033[0m"
AES_bold="\033[1m"
AES_dim="\033[2m"
AES_italic="\033[3m"
AES_underline="\033[4m"
AES_blink="\033[5m"
AES_rblink="\033[6m"
AES_invert="\033[7m"
AES_hidden="\033[8m"
AES_fblack="\033[30m"
AES_fred="\033[31m"
AES_fgreen="\033[32m"
AES_fyellow="\033[33m"
AES_fblue="\033[34m"
AES_fmagenta="\033[35m"
AES_fcyan="\033[36m"
AES_fwhite="\033[37m"
AES_bblack="\033[40m"
AES_bred="\033[41m"
AES_bgreen="\033[42m"
AES_byellow="\033[43m"
AES_bblue="\033[44m"
AES_bmagenta="\033[45m"
AES_bcyan="\033[46m"
AES_bwhite="\033[47m"

# output error message to stderr
Msg_err() {
    fixedtext="${AES_bold}${AES_fred}ERROR:${AES_reset} "
    printf "${fixedtext}$*" 1>&2
    unset fixedtext
}

# output warning message to stderr
Msg_warn() {
    fixedtext="${AES_bold}${AES_fyellow}WARNING:${AES_reset} "
    printf "${fixedtext}$*" 1>&2
    unset fixedtext
}

# output done message to stdout
Msg_done() {
    fixedtext="${AES_bold}${AES_fgreen}DONE:${AES_reset} "
    printf "${fixedtext}$*"
    unset fixedtext
}

# exchange lowercases to uppercases
Uppercase() {
    if [ $# -ne 0 ]
    then
        printf "$*" | tr '[a-z]' '[A-Z]'
    else
        cat - | tr '[a-z]' '[A-Z]'
    fi
    return $?
}

# exchange uppercases to lowercases
Lowercase() {
    if [ $# -ne 0 ]
    then
        printf "$*" | tr '[A-Z]' '[a-z]'
    else
        cat - | tr '[A-Z]' '[a-z]'
    fi
    return $?
}

# return whether the specified command ($1) is installed
Cmd_exist() {
    type "$1" > /dev/null 2>&1
    return $?
}

# unset variables defined here
Unset_lib_var() {
    :
}

# unset functions defined here
Unset_lib_fnc() {
    :
}

