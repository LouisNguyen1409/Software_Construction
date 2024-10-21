#!/bin/dash

while IFS= read -r line
do
	echo "$line" | tr "0123456789" "<<<<<5>>>>"
done