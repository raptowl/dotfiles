. "$DOTFILES_DIR/lib/list_files_with_hidden.sh"
################################
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
################################
check_dir_empty() {
  l_dir="${1:-.}"
  if [ ! -d "$l_dir" ]; then
    unset l_dir
    return 2
  fi

  {
    list_files_with_hidden "$l_dir"
    unset l_dir
  } \
    | grep -e '^' > /dev/null 2>&1 \
    && return 1

  return 0
}
