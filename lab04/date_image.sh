#!/bin/dash

for img in "$@"; do
    mod_time=$(find . -name "$img" -printf "%t")
    mogrify -gravity south -pointsize 36 -draw "text 0,10 '$mod_time'" "$img" &&
    touch -d "$mod_time" "$img"
done