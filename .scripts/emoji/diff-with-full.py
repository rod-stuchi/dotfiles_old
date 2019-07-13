import os
import psutil

def proper_title(words):
    import re
    """Proper TitleCase words (skiping some words)"""
    splited_words = map(lambda x: x.lower(), words.split(' '))
    rg = re.compile(r'^d[aeiou]s?$', re.I)
    title_words = map(lambda x: x.capitalize() if not rg.match(x) else x, splited_words)
    return ' '.join(title_words)

lines_full_emoji = []
with open('emojis-full', 'r') as f:
    liner = f.readline()
    while liner:
        line = liner.rstrip().split('\t')
        lines_full_emoji.append(line)
        liner = f.readline()

lines_emoji = []
with open('emojis-12','r') as f:
    liner = f.readline()
    while liner:
        line = liner.rstrip().split('\t')
        lines_emoji.append(line)
        liner = f.readline()


full_emoji = set(map(lambda x: x[0], lines_full_emoji))
emoji = set(map(lambda x: x[0], lines_emoji))
diff = emoji.difference(full_emoji)

# ================================ PRINT DIFF ================================
# from pprint import pprint
# pprint(diff, indent=1, width=5)

for loe in lines_emoji:
    if loe[0] in diff:
        emoji_title = proper_title(" ".join(loe[1:]))
        line = f'{loe[0]}\t{emoji_title}\n'
        print(line, end='')

pid = psutil.Process(os.getpid())
print(pid.memory_info().rss / 1024 / 1024)

#  ============================ WRITES DIFF FILE ============================
# with open('emojis-diffs', 'w') as w:
#     for loe in lines_emoji:
#         if loe[0] in diff:
#             emoji_title = proper_title(" ".join(loe[1:]))
#             line = f'{loe[0]}\t{emoji_title}\n'
#             w.write(line)
