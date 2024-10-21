#!/usr/bin/python3

import fileinput, sys

def fmt(n, line):
    if len(line) <= n:
        return line
    space_indexes = [i for i, c in enumerate(line) if c == " "]
    if not space_indexes:
        return line
    index = space_indexes[0]
    space_indexes_less_n = [i for i in space_indexes if i < n]
    if space_indexes_less_n:
        index = space_indexes_less_n[-1]
    return line[:index] + "\n" + fmt(n, line[index + 1:])


n = int(sys.argv[1])
with fileinput.input(files=sys.argv[2], inplace=True) as f:
    for line in f:
        print(fmt(n, line.rstrip("\n")))