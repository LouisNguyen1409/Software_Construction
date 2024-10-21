#!/bin/dash

for file in "$1"/*; do
	diff "$file" "$2" > /dev/null 2>&1 && basename "$file"
done