#!/usr/bin/env python3

import sys

n = int(sys.argv[1])
string = sys.argv[2]
string = string.replace('\\', '\\\\').replace('"', '\\"')
program = repr(string)
for _ in range(n - 1):
    program = f'print({repr(program)})'
program =  f'#!/usr/bin/env python3\n{program}'
print(program)
