. "$DOTFILES_LOC/lib/io/_get_color_number.sh"
################################
# Print ANSI escape sequence for foreground color
# Globals:
#   None
# Arguments:
#   color name, string
# Outputs:
#   raw escape sequence, string
# Returns:
#   success, 0
#   invalid color name, 1
################################
_put_foreground_color() {
  l_color_num=$(_get_color_number "${1:-}")
  if [ -z "$l_color_num" ]; then
    unset l_color_num
    return 1
  fi
  printf '%s' "\033[3${l_color_num}m"

  unset l_color_num
  return 0
}
