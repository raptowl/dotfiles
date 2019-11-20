#!/bin/sh

# a function to output warning message
warning() {
  printf '[WARNING] %s: %s\n' "${0##*/}" "$1" >&2
}
