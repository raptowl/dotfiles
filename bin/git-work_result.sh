#!/bin/sh

set -u


author='raptowl'
time_='00:00:00'

#start_date=$(date +'%Y/%m/%d')
start_date='2024/12/29'" $time_"
end_date='2024/12/30'" $time_"

git log --numstat --pretty="%H" --author="$author" --since="$start_date" --until="$end_date" --no-merges | \
grep -e '^[0-9][0-9]*	[0-9][0-9]*	' | \
awk -F '\t' 'BEGIN {plus_ = 0; minus_ = 0}; {plus_ += $1; minus_ += $2}; END { print plus_, minus_ }' | \
sed -e 's/^\([0-9][0-9]*\) \([0-9][0-9]*\)$/add=\1,delete=\2/'
