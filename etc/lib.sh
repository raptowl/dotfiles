#!/bin/sh

############################################################
# VARIABLES
############################################################

############################################################
# FUNCTIONS
############################################################

# return whether the specified command ($1) is installed
is_exist() {
    type "$1" > /dev/null 2>&1
    return $?
}

# unset defined functions
unset_functions() {
    unset -f is_exist
}

