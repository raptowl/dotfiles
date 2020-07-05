################################
# Get a location of its own script
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   script location, string
# Returns:
#   success, 0
#   failure, 1
################################
get_script_location() {
  l_scriptpath="${0%/*}/"
  if [ "_$l_scriptpath" = "_$0/" ]; then
    l_scriptpath='./'
  fi
  cd "$l_scriptpath" \
    || return 1
  pwd

  unset l_scriptpath
  return 0
}
