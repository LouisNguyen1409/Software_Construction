#!/bin/dash

if [ "$#" != 2 ]
then
	echo "Usage: ./echon.sh <number of lines> <string>" >&2
	exit 1
fi

if [ "$1" -ge 0 ] 2> /dev/null
then
	:
else
	echo "./echon.sh: argument 1 must be a non-negative integer" >&2
	exit 1
fi

counter=0
while [ "$counter" -lt "$1" ]
do
	echo "$2"
	counter=$((counter + 1))
done