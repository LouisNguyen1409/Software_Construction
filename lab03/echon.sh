#! /usr/bin/env dash

if test $# -eq 2
then
	:
else
	echo "Usage: ./echon.sh <number of lines> <string>" >& 2
	exit 1
fi

if test $1 -ge 0 2> /dev/null
then
	:
else
	echo "./echon.sh: argument 1 must be a non-negative integer" >& 2
	exit 1
fi

i=0
while test $i -lt $1 2> /dev/null
do
	echo "$2"
	i=$((i + 1))
done