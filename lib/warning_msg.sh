################################################################
#
# warning_msg.sh
#   - output warning message
#
# written by raptowl on 2019/11/22
#
################################################################

# $1: message to output to stderr
warning_msg() {
  printf '\033[1;33m[WARNING]\033[0m %s: %s\n' "${0##*/}" "$1" >&2
}
