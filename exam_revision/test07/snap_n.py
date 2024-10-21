#!/usr/bin/env python3

import sys

temp = {}

count = int(sys.argv[1])

for line in sys.stdin:
	line = line.strip()
	if not (line in temp):
		temp[line] = 1

	if (temp[line] == count):
		print(f"Snap: {line}")
		break

	temp[line]+=1