#!/bin/sh

# a function to output warning message
warning() {
  printf '\033[33m[WARNING]\033[0m %s: %s\n' "${0##*/}" "$1" >&2
}
