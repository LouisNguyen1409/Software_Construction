#!/usr/bin/env python3

import sys
string = sys.argv[1]

string = string.replace('\\', '\\\\').replace('"', '\\"')
result_program = f'#!/usr/bin/env python3\nprint("""{string}""")'
print(result_program)