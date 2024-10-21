#!/bin/dash

if [ $# != 1 ]; then
	echo "Usage: $0 <snapshot-number>" 1>&2
	exit 1
fi

index=$1
directory=".snapshot.$index"
if ! [ -d "$directory" ]; then
    echo "Unknown snapshot $index" 1>&2
    exit 1
fi
snapshot-save.sh
echo "Restoring snapshot $index"
cp -p "$directory"/* .