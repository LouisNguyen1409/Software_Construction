#!/usr/bin/env python3
import sys

count = 0
for file in sys.argv[1:]:
	with(open(file)) as f:
		lines = f.readlines()

	for line in lines:
		line = line.strip()
		_, time, word = line.split(maxsplit=2)
		if (word == "Orca"):
			count += int(time)
print(f"{count} Orcas reported")