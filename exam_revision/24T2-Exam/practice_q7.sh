#! /usr/bin/env dash

for pathname in "$@"; do
    case "$(head -n 1 "$pathname")" in
        *perl*)   extension="pl" ;;
        *python*) extension="py" ;;
        *sh*)     extension="sh" ;;
        *)        extension=""   ;;
    esac

    new_pathname="$pathname.$extension"
	if echo "$pathname" | grep -Eq '\.[^/]+$'; then
		echo "# $pathname already has an extension"
	elif head -n 1 "$pathname" | grep -Evq '^#!'; then
		echo "# $pathname does not have a #! line"
	elif [ -z "$extension" ]; then
		echo "# $pathname no extension for #! line"
	elif [ -e "$new_pathname" ]; then
		echo "# $new_pathname already exists"
	else
		echo "mv $pathname $new_pathname"
	fi
done