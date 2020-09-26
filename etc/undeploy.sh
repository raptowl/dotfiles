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
. "$DOTFILES_DIR/lib/list_files.sh"
. "$DOTFILES_DIR/lib/check_dir_empty.sh"


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
  log_error "invalid arguments: $@"
  exit 1
fi

######################################################################
# main routine
######################################################################


# define variables
#src_dir="$DOTFILES_DIR/conf"
src_dir="$DOTFILES_DIR"
tgt_dir="$HOME"


rm_q_flag() {
  printf 'remove: %s\n' "$*" >&2
  if [ -z "$opt_quiet" ]; then
    rm -f "$@"
  fi
}


mv_q_flag() {
  printf 'rename: %s -> %s\n' "$1" "$2" >&2
  if [ -z "$opt_quiet" ]; then
    mv "$1" "$2"
  fi
}


if [ -n "$opt_quiet" ]; then
  printf 'Quiet mode ...\n' >&2
fi


cd "$src_dir" \
  || exit 1
for file_ in * .* .config/*; do
  if [    "$file_" = "LICENSE" \
       -o "$file_" = "README.md" \
       -o "$file_" = "bin" \
       -o "$file_" = "etc" \
       -o "$file_" = "lib" \
       -o "$file_" = "." \
       -o "$file_" = ".." \
       -o "$file_" = ".config" \
       -o "$file_" = ".git" \
       -o "$file_" = ".github" \
       -o "$file_" = ".gitignore" ]
  then
    continue
  fi

  if [ -h "$tgt_dir/$file_" ]; then
    rm_q_flag "$tgt_dir/$file_"
  fi
  if [ -e "$tgt_dir/${file_}.dotold" ]; then
    mv_q_flag "$tgt_dir/${file_}.dotold" "$tgt_dir/$file_"
  fi
done


if [ -d "$tgt_dir/.config" ] \
     && check_dir_empty "$tgt_dir/.config"
then
  rmdir "$tgt_dir/.config"
fi


exit 0
