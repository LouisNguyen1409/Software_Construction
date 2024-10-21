#!/usr/bin/env python3

import sys

file = open(sys.argv[3], 'w')
start = int(sys.argv[1])
end = int(sys.argv[2]) + 1
for index in range(start, end):
	print(index, file=file)