. "$DOTFILES_LOC/lib/io/color_term.sh"
################################
# Output information log message
# Globals:
#   None
# Arguments:
#   body message, string
# Outputs:
#   log message, stderr
# Returns:
#   success, 0
################################
logging_info() {
  printf '%s %s: %s\n' \
         "$(color_term -b blue none '[INFO]')" "${0##*/}" "$1" >&2
  return 0
}
