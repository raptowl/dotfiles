#!/bin/sh

set -eu
umask 0022

# path to the configuration file
path_conf="$HOME/.dal.conf"

# check configuration file
if [ ! -f "$path_conf" ]; then
	printf 'ERROR: %s not found.\n' "$path_conf" 1>&2
	exit 1
fi

# check the number of arguments
if [ $# -ne 1 ]; then
	printf 'ERROR: the number of arguments is incorrect.\n' 1>&2
	exit 1
fi

# main routine
case $1 in
'-f' )
	exec $(grep -v -e '^#' < "$path_conf" | \
		grep -e '^file=' | \
		tail -n 1 | \
		sed -e 's/^file=//')
	;;
'-i' )
	exec $(grep -v -e '^#' < "$path_conf" | \
		grep -e '^image=' | \
		tail -n 1 | \
		sed -e 's/^image=//')
	;;
'-m' )
	exec $(grep -v -e '^#' < "$path_conf" | \
		grep -e '^mail=' | \
		tail -n 1 | \
		sed -e 's/^mail=//')
	;;
'-s' )
	exec $(grep -v -e '^#' < "$path_conf" | \
		grep -e '^sound=' | \
		tail -n 1 | \
		sed -e 's/sound=//')
	;;
'-t' )
	exec $(grep -v -e '^#' < "$path_conf" | \
		grep -e '^terminal=' | \
		tail -n 1 | \
		sed -e 's/^terminal=//')
	;;
'-v' )
	exec $(grep -v -e '^#' < "$path_conf" | \
		grep -e '^video=' | \
		tail -n 1 | \
		sed -e 's/^video=//')
	;;
'-w' )
	exec $(grep -v -e '^#' < "$path_conf" | \
		grep -e '^web=' | \
		tail -n 1 | \
		sed -e 's/^web=//')
	;;
* )
	printf 'ERROR: %s is not defined.\n' "$1" 1>&2
	exit 1
	;;
esac

