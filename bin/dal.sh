#!/bin/sh

set -u
umask 0022
IFS=$(printf ' \t\n_'); IFS=${IFS%_}
export IFS

# path to the configuration file
path_conf="$HOME/.dal.conf"

# check configuration file
if [ ! -f "$path_conf" ]; then
    printf "ERROR: %s not found.\\n" "$path_conf" 1>&2
    exit 1
fi

# check the number of arguments
if [ $# -ne 1 ]; then
    printf "ERROR: the number of arguments is incorrect.\\n" 1>&2
    exit 1
fi

# main routine
case $1 in
"-f" )  exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "file="                 |
                sed -e "s/file=//"              |
                head -n 1)"
        ;;
"-i" )  exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "image="                |
                sed -e "s/image=//"             |
                head -n 1)"
        ;;
"-m" )  exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "mail="                 |
                sed -e "s/mail=//"              |
                head -n 1)"
        ;;
"-s" )  exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "sound="                |
                sed -e "s/sound=//"             |
                head -n 1)"
        ;;
"-t" )  exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "terminal="             |
                sed -e "s/terminal=//"          |
                head -n 1)"
        ;;
"-v" )  exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "video="                |
                sed -e "s/video=//"             |
                head -n 1)"
        ;;
"-w" )  exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "web="                  |
                sed -e "s/web=//"               |
                head -n 1)"
        ;;
* )     printf "ERROR: %s is not defined.\\n" "$1" 1>&2
        exit 1
        ;;
esac

