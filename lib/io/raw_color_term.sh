. "$DOTFILES_LOC/lib/io/_put_background_color.sh"
. "$DOTFILES_LOC/lib/io/_put_bold_color.sh"
. "$DOTFILES_LOC/lib/io/_put_foreground_color.sh"
. "$DOTFILES_LOC/lib/io/_put_reset_color.sh"
################################
# Print color text to console
# Globals:
#   None
# Arguments:
#   [-b], bold color switch
#   foreground color
#   background color
#   body text
# Outputs:
#   colored string
# Returns:
#   success, 0
#   invalid specifier, 1
################################
raw_color_term() {
  l_prefix=''
  while printf '%s' "$1" | grep '^-' > /dev/null 2>&1; do
    case "$(printf '%s' "$1" | sed 's/-//')" in
      b)  l_prefix="${l_prefix}""$(_put_bold_color)" ;;
    esac
    shift 1
  done
  if [ $# -ne 3 ]; then
    return 1
  fi

  l_fore_color=$(_put_foreground_color "$1")
  l_back_color=$(_put_background_color "$2")
  l_body_text=$(printf '%s' "$3")
  printf '%s' \
         "${l_prefix}${l_fore_color}${l_back_color}${l_body_text}"\
         "$(_put_reset_color)"

  unset l_prefix l_fore_color l_back_color l_body_text
  return 0
}
