#!/usr/bin/env python3

import re, sys
counter = 0
for line in sys.stdin:
	words = re.findall(r"[a-zA-Z]+", line)
	counter += len(words)

print(counter, "words")