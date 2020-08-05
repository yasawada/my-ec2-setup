#!/usr/bin/env python3

import os
import sys
from ftfy import fix_text
from ftfy.fixes import decode_escapes

def do_ftfy(f):
    with open(f, 'r') as f:
        lines = f.readlines()
        for line in lines:
            print(fix_text(decode_escapes(line)).rstrip())

if __name__ == '__main__':
    args = sys.argv
    if len(args) < 2:
        print("Usage: {} [filename]".format(args[0]))
        sys.exit(1)

    celog = args[1]
    if os.path.exists(celog):
        do_ftfy(celog)
    else:
        print("What's?!")