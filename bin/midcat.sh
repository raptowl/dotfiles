#!/bin/sh

cat "$1" | head -n $3 | tail -n `expr $3 - $2 + 1`

