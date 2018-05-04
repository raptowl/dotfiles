#!/bin/sh

set -u

path_configfile="$HOME/.dal.conf"

# check configfile
if [ ! -f "$path_configfile" ]; then
    printf "ERROR: %s not found.\\n" "$path_configfile" 1>&2
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
"w" )   exec "$(grep -v -e "^#" < "$path_configfile"    |
                grep -e "web_browser="                  |
                sed -e "s/web_browser=//"               |
                tail -n 1)"
        ;;
"m" )   exec "$(grep -v -e "^#" < "$path_configfile"    |
                grep -e "mailer="                       |
                sed -e "s/mailer=//"                    |
                tail -n 1)"
        ;;
"f" )   exec "$(grep -v -e "^#" < "$path_configfile"    |
                grep -e "file_manager="                 |
                sed -e "s/file_manager=//"              |
                tail -n 1)"
        ;;
* )     printf "ERROR: %s is not defined.\\n" "$1"
        exit 1
        ;;
esac

