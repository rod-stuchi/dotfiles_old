#! /bin/python

import os
import sys

def show_help():
    print("""usage:
  # to seed the result
    \x1b[44;97m {file01} ∉ {file02} \x1b[0m, items in file01 not in file02\n
    \x1b[93m$ python diff.py --print \x1b[1m{file01} {file02}\x1b[0m

  # to save the result in {result}\n
    python diff.py --print {file01} {file02} > {new_file}

  # file must be in this format: ^{emoji}\\t{description}$, e.g.:
  [🐍	Snake]

    """)
    exit(0)

if len(sys.argv) == 1:
    show_help()
elif len(sys.argv) < 4:
    show_help()
elif '--print' not in sys.argv:
    show_help()

def proper_title(words):
    import re
    """Proper TitleCase words (skiping some words)"""
    splited_words = map(lambda x: x.lower(), words.split(' '))
    rg = re.compile(r'^d[aeiou]s?$', re.I)
    title_words = map(lambda x: x.capitalize() if not rg.match(x) else x, splited_words)
    return ' '.join(title_words)

file01, file02 = ([], [])
file01_path = sys.argv[2:3][0]
file02_path = sys.argv[3:4][0]

if not os.path.exists(file01_path):
    print(f'⚠ file: \'{file01_path}\' not found.')
    exit(1)

if not os.path.exists(file02_path):
    print(f'⚠ file: \'{file02_path}\' not found.')
    exit(1)

for file_path, file_list in zip([file01_path, file02_path], [file01, file02]):
    with open(file_path, 'r', encoding='utf-8') as f:
        liner = f.readline()
        while liner:
            if not liner.startswith('#'):
                line = liner.rstrip().split('\t')
                file_list.append(line)
            liner = f.readline()

set_file01 = set(map(lambda x: x[0], file01))
set_file02 = set(map(lambda x: x[0], file02))
diff = set_file01.difference(set_file02)

for d in sorted(diff):
    label = next(filter(lambda l: l[0] == d, file01), None)[1]
    label = proper_title(label.upper())
    print(f'{d}\t{label}')
