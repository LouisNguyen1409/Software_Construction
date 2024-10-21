#!/bin/dash

num_file="$1"
file_name="$2"
index=1
while [ "$index" -le "$num_file" ]; do
	echo "hello $file_name" > "hello$index.txt"
	index=$((index + 1))
done