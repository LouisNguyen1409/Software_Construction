#!/usr/bin/env python3

import sys

with(open(sys.argv[2])) as f:
	lines = f.readlines()

index = int(sys.argv[1]) - 1
if index < len(lines):
	print(lines[index], end='')