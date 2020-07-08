################################
# List up directories in PATH
# Globals:
#   PATH
# Arguments:
#   None
# Outputs:
#   directory paths
# Returns:
#   success, 0
################################
list_path() {
  printf '%s\n' "$PATH" \
    | tr ':' '\n'

  return 0
}
