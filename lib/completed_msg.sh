################################################################
#
# completed_msg.sh
#   - output completed message
#
# written by raptowl on 2019/11/26
#
################################################################

# $1: completed message to output to stderr
completed_msg() {
  printf '\033[1;32m[COMPLETED]\033[0m %s: %s\n' "${0##*/}" "$1" >&2
}
