init_env() {
  # Initialize environments options and variables
  # Globals:
  #   LC_ALL
  #   UNIX_STD
  #   PATH
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   success, 0
  set -u
  umask 0022
  LC_ALL=C
  UNIX_STD=2003  # to make HP-UX conform to POSIX
  PATH="$(command -p getconf PATH 2>/dev/null)${PATH+:}${PATH-}"
  case "$PATH" in
    :*) PATH=${PATH#?} ;;
  esac
  export LC_ALL UNIX_STD PATH

  return 0
}
