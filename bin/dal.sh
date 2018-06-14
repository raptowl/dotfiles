#!/bin/sh

set -u
umask 0022
IFS=$(printf ' \t\n_'); IFS=${IFS%_}
export IFS

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

# show help of this command
if [ "$1" = "--help" ]; then
    cat << _EOT_
dal.sh is default application launcher.
_EOT_
fi

case $1 in
"w" )   exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "web="                  |
                sed -e "s/web=//"               |
                tail -n 1)"
        ;;
"m" )   exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "mail="                 |
                sed -e "s/mail=//"              |
                tail -n 1)"
        ;;
"f" )   exec "$(grep -v -e "^#" < "$path_conf"  |
                grep -e "file="                 |
                sed -e "s/file=//"              |
                tail -n 1)"
        ;;
* )     printf "ERROR: %s is not defined.\\n" "$1"
        exit 1
        ;;
esac

