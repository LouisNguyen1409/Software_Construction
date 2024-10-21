#!/usr/bin/env python3

import sys


n = int(sys.argv[1])
counts = {}
for line in sys.stdin:
    line = line.strip("\n")
    if line in counts:
        counts[line] += 1
    else:
        counts[line] = 1

    if counts[line] == n:
        print(f"Snap: {line}")
        break