#!/bin/dash

num="$1"
name="$2"
counter=1

while [ "$counter" -le "$num" ]; do
	echo "hello $name" >> "hello$counter".txt
	counter=$((counter + 1))
done