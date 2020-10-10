#!/bin/sh
# >> __description__
# Short description here ...
# ...
# <<


######################################################################
# preprocessing
######################################################################


# load library functions
. "$DOTFILES_DIR/lib/init_env.sh"
. "$DOTFILES_DIR/lib/parse_usage.sh"
. "$DOTFILES_DIR/lib/log_error.sh"


# initialize shell environment
init_env


# parse options
# s: switch, no need any values (ex. -s)
# v: value, need to input some values (ex. -k abc)
# o: optional, no need to specify (e.g. [-s])
while :; do
  case "${1:-}" in
    -h|--help)  # >> __option__[so]:print out the usage to stderr
      parse_usage
      exit 0
      ;;
    --)  # >> __option__[so]
      shift
      break
      ;;
    -*)
      log_error "invalid option: $1"
      exit 1
      ;;
    *)
      break
      ;;
  esac
done


######################################################################
# main routine
######################################################################


# catch signals
#trap '' EXIT HUP INT QUIT TERM


exit 0
