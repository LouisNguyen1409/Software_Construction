#!/bin/dash

if [ $# != 0 ]; then
    echo "Usage: $0" 1>&2
    exit 1
fi

index=0
while [ -e ".snapshot.$index" ]; do
    index=$((index + 1))
done

echo "Creating snapshot $index"
directory=".snapshot.$index"
mkdir $directory || exit 1

for filename in *; do
    if [ -f "$filename" ]; then
        case "$filename" in
            snapshot-save.sh|snapshot-load.sh) continue ;;
            *) cp -p "$filename" "$directory" ;;
        esac
    fi
done