#!/usr/bin/env python3

import sys
file = open(sys.argv[2], 'r')
lines = file.readlines()
line = int(sys.argv[1]) - 1
if len(lines) > line:
	print(lines[line], end='')