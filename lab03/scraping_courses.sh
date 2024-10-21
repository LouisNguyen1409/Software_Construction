#! /usr/bin/env dash

if [ $# -eq 2 ] 2>/dev/null
then
	:
else
	echo "Usage: ./scraping_courses.sh <year> <course-prefix>"
	exit 1
fi

if [ "$1" -ge 2019 ] 2>/dev/null && [ "$1" -le 2024 ] 2>/dev/null
then
	:
else
	echo "./scraping_courses.sh: argument 1 must be an integer between 2019 and 2024"
	exit 1
fi

year=$1
prefix=$2

url="https://api-ap-southeast-2.prod.courseloop.com/publisher/search-all?from=0&query=&searchType=advanced&siteId=unsw-prod-pres&siteYear=$year&size=10000"
response=$(wget -qO- "$url")


courses=$(echo "$response" | jq -r '.data.results[] | select(.lines[0] == "Course" and (.lines[1] == "Undergraduate" or .lines[1] == "Postgraduate")) | .code + " " + .title' | tr -s ' ')


filtered_courses=$(echo "$courses" | grep -E "^${prefix}[A-Z]*[0-9]+ "| sort | uniq )
if [ -z "$filtered_courses" ]; then
    :
else
    echo "$filtered_courses"
fi
