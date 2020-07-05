################################
# Print files list with hiddens in the directory
# Globals:
#   None
# Arguments:
#   target directory, string
# Outputs:
#   filelist
# Returns:
#   success, 0
#   directory not found, 1
################################
list_files_with_hidden() {
  l_dir=$(printf '%s' "${1:-.}" \
            | sed -e 's%/$%%')
  if [ ! -d "$l_dir" ]; then
    return 1
  fi
  printf '%s\n' "$l_dir/"* "$l_dir/".* \
    | grep -v \
        -e '/\*$' \
        -e '/\.$' \
        -e '/\.\.$'

  unset l_dir
  return 0
}
