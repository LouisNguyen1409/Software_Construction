#! /bin/dash

YEAR=2024

# Check the number of arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <course prefix>"
    exit 1
fi

course_prefix="$1"


if ! echo "${course_prefix}" | grep -Eq '^[A-Z]{4}$'; then
    echo "Invalid course prefix: ${course_prefix}"
    exit 1
fi

url="http://www.timetable.unsw.edu.au/${YEAR}/${course_prefix}KENS.html"

page_content=$(curl --location --silent "${url}")
course_links=$(echo "${page_content}" | grep -E "${course_prefix}[0-9]{4}\.html")
clean_links=$(echo "${course_links}" | sed 's/.*href="//
                                      s/.html">/ /
                                      s/<.*//')
filtered_links=$(echo "${clean_links}" | grep -Ev "${course_prefix}[0-9]{4} ${course_prefix}[0-9]{4}$" | sort | uniq -w8)

echo "${filtered_links}"