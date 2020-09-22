put_bold_color() {
  # Print ANSI escape sequence for bold foreground
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   raw escape sequence, string
  # Returns:
  #   success, 0
  printf '%s' '\033[1m'

  return 0
}
