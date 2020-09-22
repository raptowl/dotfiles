. "$DOTFILES_DIR/lib/get_color_number.sh"
put_background_color() {
  # Print ANSI escape sequence for background color
  # Globals:
  #   None
  # Arguments:
  #   color name, string
  # Outputs:
  #   raw escape sequence, string
  # Returns:
  #   success, 0
  #   invalid color name, 1
  l_color_num=$(get_color_number "${1:-}")
  if [ -z "$l_color_num" ]; then
    unset l_color_num
    return 1
  fi
  printf '%s' "\033[4${l_color_num}m"

  unset l_color_num
  return 0
}
