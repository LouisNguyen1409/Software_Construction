#!/usr/bin/env python3

import sys

with(open(sys.argv[1])) as f:
	lines = f.readlines()
	lines.reverse()

file = open(sys.argv[2], "w")
for line in lines:
	print(line, file=file, end='')