#! /bin/sh

emoji=`
  rg -v "#$|^#" ~/.scripts/emoji/emojis-full \
  | rofi -i -matching regex -dmenu -location 0 \
    -no-disable-history \
    -cache-dir ~/.scripts/emoji/.rofi-cache \
    -dpi 150 -width 40 -lines 25 -multi-select \
    -theme ~/.config/rofi/Monokai.rasi \
  | awk '{print $1}' \
  | tr -d '\n'
`

if [[ ! -z $emoji ]]; then
  xclip -sel clip <<< $emoji
  pgrep -x dunst >/dev/null && notify-send "[$(xclip -o -selection clipboard)] copied."
fi


# sites
# https://emojipedia.org/
# https://www.piliapp.com/emoji/list/
# https://www.piliapp.com/twitter-symbols/
# https://www.piliapp.com/emoji/list/
# https://github.com/joypixels/emojione
