list_files() {
  # Print files list in the directory
  # Globals:
  #   None
  # Arguments:
  #   [-h], list with hidden files
  #   target directory, string
  # Outputs:
  #   filelist
  # Returns:
  #   success, 0
  #   directory not found, 1
  #   invalid options, 1
  while :; do
    case "$1" in
      -h) lopt_hidden=true ;;
      * ) break ;;
    esac
    shift
  done
  if [ $# -gt 1 ]; then
    unset lopt_hidden
    return 1
  fi

  l_dir=$(printf '%s' "${1:-.}" \
            | sed -e 's%/$%%')
  if [ ! -d "$l_dir" ]; then
    unset lopt_hidden l_dir
    return 1
  fi

  if [ -n "${lopt_hidden:-}" ]; then
    printf '%s\n' "$l_dir/"* "$l_dir/".* \
      | grep -v -e '/\*$' \
                -e '/\.$' \
                -e '/\.\.$'
  else
    printf '%s\n' "$l_dir/"*
  fi

  unset lopt_hidden l_dir
  return 0
}
