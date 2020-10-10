#!/bin/sh
# >> parse_and_print_usage[description]
# Short description here ...
# ...
# << parse_and_print_usage[description]


######################################################################
# preprocessing
######################################################################


# initialize shell environment
set -u
umask 0022
LC_ALL=C
type command > /dev/null 2>&1 && type getconf > /dev/null 2>&1 &&
PATH="$(command -p getconf PATH)${PATH+:}${PATH-}"
UNIX_STD=2003
export LC_ALL PATH UNIX_STD


# load and define functions
. "$DOTFILES_DIR/lib/log_error.sh"


# catch signals
#trap '' EXIT HUP INT QUIT TERM


######################################################################
# argument parsing
######################################################################


# print the usage and exit
case "$# ${1:-}" in
  '1 -h'|'1 --help')
    #parse_and_print_usage
    :
    ;;
esac


# parse option
opt_quiet=
while :; do
  case "${1:-}" in
    --)
      shift
      break
      ;;
    -q)
      opt_quiet=true
      shift
      ;;
    -*)
      log_error "invalid option: $1"
      exit 1
      ;;
    *)  break ;;
  esac
done


if [ $# -ne 0 ]; then
  log_error "invalid arguments: $*"
  exit 1
fi


######################################################################
# main routine
######################################################################


# define variables
src_dir="$DOTFILES_DIR/conf"
tgt_dir="$HOME"


# define functions
mkdir_q_flag() {
  printf 'mkdir: %s\n' "$*" >&2
  if [ -z "$opt_quiet" ]; then
    mkdir "$@"
  fi
}


mv_q_flag() {
  printf 'rename: %s -> %s\n' "$1" "$2" >&2
  if [ -z "$opt_quiet" ]; then
    mv "$1" "$2"
  fi
}


ln_q_flag() {
  printf 'put symbolic link: %s -> %s\n' "$1" "$2" >&2
  if [ -z "$opt_quiet" ]; then
    ln -s "$1" "$2"
  fi
}


# main routine
if [ -n "$opt_quiet" ]; then
  printf 'Quiet mode ...\n' >&2
fi


if [ ! -d "$tgt_dir/.config" ]; then
  mkdir_q_flag -p "$tgt_dir/.config"
fi


cd "$src_dir" \
  || exit 1
for file_ in * .* .config/* .config/.*; do
  if [      "$file_" = "*" ] \
       || [ "$file_" = "." ] \
       || [ "$file_" = ".." ] \
       || [ "$file_" = ".config" ] \
       || [ "$file_" = ".config/*" ] \
       || [ "$file_" = ".config/." ] \
       || [ "$file_" = ".config/.." ]; then
    continue
  fi

  if [ ! -e "$tgt_dir/$file_" ]; then
    ln_q_flag "$src_dir/$file_" "$tgt_dir/$file_"
  elif [        -e "$tgt_dir/$file_" ] \
         && [ ! -h "$tgt_dir/$file_" ]; then
    mv_q_flag "$tgt_dir/$file_" "$tgt_dir/${file_}.dotold"
    ln_q_flag "$src_dir/$file_" "$tgt_dir/$file_"
  fi
done


exit 0
