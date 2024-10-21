#!/usr/bin/env python3

import sys
file_r = open(sys.argv[1], 'r')
file_w = open(sys.argv[2], 'w')
lines = file_r.readlines()
lines.reverse()
for line in lines:
	print(line, file=file_w, end='')