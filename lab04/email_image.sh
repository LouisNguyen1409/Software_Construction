#!/bin/dash

for image in "$@"
do
	display "$image"
	printf "Address to e-mail this image to? "
	read email
	if [ -n "$email" ]
	then
		printf "Message to accompany image? "
		read msg
		echo "$msg" | mutt -s 'image' -a "$image" -e 'set copy=no' -- "$email"
		echo "$image sent to $email"
	else
		echo "No email sent"
	fi
done
