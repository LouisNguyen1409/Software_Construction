#!/usr/bin/env python3
import sys
import re

shift = int(sys.argv[1])
for line in sys.stdin:
    encrypted_line = ''
    for char in line:
        if char.isalpha():
            if char.isupper():
                start = ord('A')
            else:
                start = ord('a')
            shifted = ord(char) - start
            shifted = (shifted + shift) % 26
            encrypted_char = chr(shifted + start)
        else:
            encrypted_char = char

        encrypted_line += encrypted_char

    print(encrypted_line, end='')