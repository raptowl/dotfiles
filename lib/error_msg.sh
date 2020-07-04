################################################################
#
# error_msg.sh
#   - output error message
#
# written by raptowl on 2019/11/26
#
################################################################

# $1: error message to output to stderr
error_msg() {
  printf '\033[1;31m[ERROR]\033[0m %s: %s\n' "${0##*/}" "$1" >&2
}
