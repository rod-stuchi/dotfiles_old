import random
import os

HOME_PATH = os.getenv("HOME")
lines = []

with open(os.path.join(HOME_PATH, '.scripts/emoji/emojis-full-2'), 'r') as f:
    liner = f.readline()
    while liner:
        if not liner.startswith('#'):
            line = liner.rstrip().split('\t')
            if len(line[0]) == 1:
                lines.append(line)
        liner = f.readline()

chosen = random.choice(lines)
print('#'.join(chosen))
