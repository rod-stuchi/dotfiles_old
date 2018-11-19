#! /bin/sh

rg -v "#$" ~/.scripts/emoji/emojis \
  | rofi -i -matching fuzzy -dmenu -location 2 \
    -no-disable-history -sort -levenshtein-sort \
    -dpi 130 -width 40 -lines 30 -multi-select \
    -theme ~/.config/rofi/Arc.rasi \
  | awk '{print $1}' \
  | tr -d '\n' \
  | xclip -selection clipboard
pgrep -x dunst >/dev/null && notify-send "$(xclip -o -selection clipboard) was copied."

