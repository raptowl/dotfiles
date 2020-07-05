. "$DOTFILES_LOC/lib/io/color_term.sh"
################################
# Output warning log message
# Globals:
#   None
# Arguments:
#   body message, string
# Outputs:
#   log message, stderr
# Returns:
#   success, 0
################################
logging_warning() {
  printf '%s %s: %s\n' \
         "$(color_term -b yellow none ""[WARNING]"")" "${0##*/}" "$1" >&2
  return 0
}
