#!/bin/dash

start="$1"
while [ "$start" -le "$2" ]; do
	echo "$start" >> "$3"
	start=$((start + 1))
done