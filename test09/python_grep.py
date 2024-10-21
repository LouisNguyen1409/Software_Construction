#!/usr/bin/env python3

import sys
import re

regex = re.compile(sys.argv[1])
with open(sys.argv[2], 'r') as file:
	for line in file:
		line = line.rstrip('\n')
		if regex.search(line):
			print(line)