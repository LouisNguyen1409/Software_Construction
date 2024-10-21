#!/bin/dash

for c_file in "$@"; do
	include_files=$(grep -E '^#include\s*"' "$c_file" | sed 's/[^"]*"//' | sed 's/"*$//')
	# echo "$include_files"
	for include_file in $include_files; do
		if [ ! -r "$include_file" ]; then
			echo "$include_file included into $c_file does not exist"
		fi
	done
done