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
  l_dir=$(printf '%s' "${1:-.}" \
            | sed -e 's%/$%%')
  if [ ! -d "$l_dir" ]; then
    unset l_dir
    return 2
  fi

  {
    printf '%s\n' "$l_dir/"* "$l_dir/".*
    unset l_dir
  } \
    | grep -v -e '/\*$' \
              -e '/\.$' \
              -e '/\.\.$' \
    | grep -e '^' > /dev/null 2>&1 \
    && return 1

  return 0
}
