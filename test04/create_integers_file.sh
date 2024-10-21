#!/bin/dash

i="$1"
while [ "$i" -le "$2" ]
do
		echo "$i"
		i=$((i+1))
done > "$3"