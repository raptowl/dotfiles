list_functions_recursively() {
  # Output functions namelist recursively
  # Globals:
  #   None
  # Arguments:
  #   path to lib_function, a string
  # Outputs:
  #   lib_functions namelist
  # Returns:
  #   more than one hit, 0
  #   nothing hit, or file not found, 1
  l_path=$(eval printf '%s' "${1:-}")
  if [ ! -r "$l_path" ]; then
    unset l_path
    return 1
  fi

  if ! grep -v -e '^#' "$l_path" \
         | grep -e '^..*()' > /dev/null 2>&1; then
    unset l_path
    return 1
  fi

  grep -v -e '^#' "$l_path" \
    | grep -e '^..*()' \
    | sed -e 's/().*$//' \
          -e 's/^  *//'

  for l_recursive_path in $(grep -v -e '^#' "$l_path" \
                              | grep -e '^\. .*' \
                              | sed -e 's/^\.  *//'); do
    list_functions_recursively "$l_recursive_path"
  done

  unset l_path l_recursive_path
}
