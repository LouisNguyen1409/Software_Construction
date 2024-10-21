#! /usr/bin/env python3

import sys
import re
import requests
import subprocess

YEAR = 2024

if len(sys.argv) != 2:
	print(f"Usage: {sys.argv[0]} <course prefix>")
	sys.exit(1)

course_prefix = sys.argv[1].upper()
if not re.match(r'^[A-Z]{4}$', course_prefix):
	print(f"Invalid course prefix: {course_prefix}")
	sys.exit(1)

url = f"http://www.timetable.unsw.edu.au/{YEAR}/{course_prefix}KENS.html"
result = subprocess.run(['curl', '--location', '--silent', url], 
                                capture_output=True, text=True, check=True)

content = result.stdout

courses = {}
for m in re.findall(rf"^.*{course_prefix}[0-9]{{4}}\.html.*$", content, flags=re.MULTILINE):
	m = re.search(r"""<a href="(?P<code>[A-Z]{4}[0-9]{4})\.html">(?P<name>.*?)</a>""", m)
	code = m.group('code')
	name = m.group('name')
	if code != name:
		courses[code] = name

for code, name in sorted(courses.items()):
	print(f"{code} {name}")