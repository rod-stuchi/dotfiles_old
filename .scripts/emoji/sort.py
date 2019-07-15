from pprint import pprint
import sys

def show_help():
    print("""usage:
    python sort.py --print      # to seed the result
    python sort.py --write      # to save the result in emojis-full-sorted

    """)

if len(sys.argv) == 1:
    show_help()
    exit()

def proper_title(words):
    import re
    """Proper TitleCase words (skiping some words)"""
    splited_words = map(lambda x: x.lower(), words.split(' '))
    rg = re.compile(r'^d[aeiou]s?$', re.I)
    title_words = map(lambda x: x.capitalize() if not rg.match(x) else x, splited_words)
    return ' '.join(title_words)

lines = []
with open('./emojis-full', 'r', encoding='utf-8') as f:
    liner = f.readline()
    while liner:
        line = liner.rstrip().split('\t')
        lines.append(line)
        liner = f.readline()

lines_set = set(map(lambda l: l[0], lines))
lines_sorted = sorted(lines_set)

if '--print' in sys.argv:
    for ls in lines_sorted:
        el = next(filter(lambda x: x[0] == ls, lines), None)
        if len(el) < 2:
            continue
        emoji_title = proper_title(el[1])
        line = f'{el[0]}\t{emoji_title}\n'
        print(line, end='')

elif '--write' in sys.argv:
    with open('emojis-full-sorted', 'w') as w:
        for ls in lines_sorted:
            el = next(filter(lambda x: x[0] == ls, lines), None)
            if len(el) < 2:
                continue
            emoji_title = proper_title(el[1])
            line = f'{el[0]}\t{emoji_title}\n'
            w.write(line)
