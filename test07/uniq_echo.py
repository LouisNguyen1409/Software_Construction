#!/usr/bin/env python3

import sys


seen = set()
result = []
for arg in sys.argv[1:]:
	if arg not in seen:
		seen.add(arg)
		result.append(arg)
print(" ".join(result))