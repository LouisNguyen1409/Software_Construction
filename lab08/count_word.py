#!/usr/bin/env python3

import re, sys

target = sys.argv[1].lower()

counter = 0
for line in sys.stdin:
	line = line.lower()
	words = re.findall(r'[a-z]+', line)
	for word in words:
		if word == target:
			counter += 1

print(target, "occurred", counter, "times")