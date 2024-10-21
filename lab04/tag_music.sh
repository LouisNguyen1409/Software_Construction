#!/bin/dash

for album_dir in "$@"
do
    album_name=$(basename "$album_dir")
    album_year=$(echo "$album_name" | sed -E 's/.* //')
    
    for mp3_file in "$album_dir"/*.mp3
	do
        mp3_base=$(basename "$mp3_file" .mp3)
        track_number=$(echo "$mp3_base" | sed -E 's/ - .*//')
        track_title=$(echo "$mp3_base" | sed -E 's/^[0-9]* - //; s/ - .*//')
        artist_name=$(echo "$mp3_base" | sed -E 's/.* - //')
        
        id3 -t "$track_title" -T "$track_number" -a "$artist_name" -A "$album_name" -y "$album_year" "$mp3_file" > /dev/null
    done
done
