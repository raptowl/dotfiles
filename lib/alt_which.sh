alt_which() {
  # Define altenative 'which' command
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   success, 0
  if ! which which > /dev/null 2>&1; then
    which() {
      command -v "$1" 2> /dev/null \
        | grep '^/' \
        || {
          echo 'which: not found' 1>&2 \
            && (exit 1)
        }
    }
  fi

  return 0
}
