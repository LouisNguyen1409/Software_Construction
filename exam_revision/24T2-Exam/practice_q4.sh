#!/bin/dash

index=0
prev_num=0
sort -n "$1" |  while read -r num; do
	if [ "$index" -eq 0 ]; then
		prev_num="$num"
		index=$((index + 1))
		continue
	fi
	check=$((num - 1))
	if [ "$prev_num" -eq "$check" ]; then
		prev_num="$num"
	else
		echo "$check"
		break
	fi
done