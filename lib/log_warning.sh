. "$DOTFILES_DIR/lib/color_term.sh"
log_warning() {
  # Output warning log message
  # Globals:
  #   None
  # Arguments:
  #   body message, string
  # Outputs:
  #   log message, stderr
  # Returns:
  #   success, 0
  printf '%s %s: %s\n' \
         "$(color_term -b yellow none '[WARNING]')" "${0##*/}" "$1" >&2
  return 0
}
