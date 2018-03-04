#!/bin/sh

cat $* | grep -n '.*' | sort -n -r | sed -e 's/^[0-9]*://'

