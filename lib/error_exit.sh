#!/bin/sh

# a function to output error message and exit with error status
error_exit() {
  printf '\033[31m[ERROR]\033[0m %s: %s\n' "${0##*/}" "$2" >&2
  exit "$1"
}
