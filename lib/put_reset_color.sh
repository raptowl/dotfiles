put_reset_color() {
  # Print ANSI escape sequence for reset all
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   raw escape sequence, string
  # Returns:
  #   success, 0
  printf '%s' '\033[0m'

  return 0
}
