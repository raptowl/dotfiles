. "$DOTFILES_DIR/lib/color_term.sh"
logging_error() {
  # Output error log message
  # Globals:
  #   None
  # Arguments:
  #   body message, string
  # Outputs:
  #   log message, stderr
  # Returns:
  #   success, 0
  printf '%s %s: %s\n' \
         "$(color_term -b red none '[ERROR]')" "${0##*/}" "$1" >&2
  return 0
}
