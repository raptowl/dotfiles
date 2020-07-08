################################
# Print ANSI escape sequence for reset all
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   raw escape sequence, string
# Returns:
#   success, 0
################################
_put_reset_color() {
  printf '%s' '\033[0m'

  return 0
}
