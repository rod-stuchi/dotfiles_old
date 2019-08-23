
emoji=$(python ~/.scripts/emoji/choice.py)

if [[ ! -z $emoji ]]; then
  # read icon desc <<< $(printf "$emoji" | awk -F'#' '{ print $1" "$2 }')
  # a simple way to do it with IFS
  IFS="#" read icon desc <<< $emoji
  printf "%s" $icon | xclip -sel clip
  pgrep -x dunst >/dev/null && notify-send -t 2000 "random [$(xclip -o -selection clipboard)] '$desc' copied."
fi
