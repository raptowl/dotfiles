. "$DOTFILES_DIR/lib/list_files.sh"
check_dir_empty() {
  # Check the specified directory is empty
  # Globals:
  #   None
  # Arguments:
  #   target directory, string
  # Outputs:
  #   None
  # Returns:
  #   empty, 0
  #   not empty, 1
  #   directory not found, 2
  l_dir="${1:-.}"
  if [ ! -d "$l_dir" ]; then
    unset l_dir
    return 2
  fi

  {
    list_files -h "$l_dir"
    unset l_dir
  } \
    | grep -e '^' > /dev/null 2>&1 \
    && return 1

  return 0
}
