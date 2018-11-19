#! /bin/sh

rg -v "#$" ~/.scripts/emoji/emojis | rofi -i -matching fuzzy -dmenu | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
pgrep -x dunst >/dev/null && notify-send "$(xclip -o -selection clipboard) was copied."
