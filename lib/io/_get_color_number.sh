################################
# Get color number for terminal ANSI code
# Globals:
#   None
# Arguments:
#   color name, string
# Outputs:
#   color number, integer
# Returns:
#   success, 0
#   invalid color name, 1
################################
_get_color_number() {
  case "${1:-}" in
    black  )  printf '%d' '0' ;;
    red    )  printf '%d' '1' ;;
    green  )  printf '%d' '2' ;;
    yellow )  printf '%d' '3' ;;
    blue   )  printf '%d' '4' ;;
    magenta)  printf '%d' '5' ;;
    cyan   )  printf '%d' '6' ;;
    white  )  printf '%d' '7' ;;
    none   )  printf '%d' '9' ;;
    *      )  return 1 ;;
  esac

  return 0
}
