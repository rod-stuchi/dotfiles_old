#!/bin/zsh

hex2rgb() {
  value=$(printf "rgba(%d,%d,%d,0.70)\n" 0x${1:0:2} 0x${1:2:2} 0x${1:4:2})
  # echo -n "$value" | xclip -selection clipboard
  echo $value
}

#find ~/.config/termite/base16 -name "*.config" | xargs -L 1 -i hex2rgb $(cat {} | grep background | grep -oP '(?<=#).*')
#for i in `find ./base16 -name "*.config" | sort | tail -n +5`; do
for i in `find ./base16 -name "*.config" | sort`; do
  if grep -qP 'background.*#' $i; then
    rgb=$(hex2rgb $(cat $i | grep background | grep -oP '(?<=#).*'))
    echo "changed background: {$rgb} >> " $i
    cat $i | sed -e 's/background      =.*/background      = '"$rgb"'/g' > $i"_rgb"
    sed -i -e 's/\(cursor.*\)/#\1/' $i"_rgb"
  else
    echo "already parsed >>" $i
  fi
done

