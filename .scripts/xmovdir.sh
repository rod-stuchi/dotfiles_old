#! /bin/bash

files=$(ls *.{mkv,avi,mp4} 2>/dev/null)
for f in $files; do
  ext=$(echo $f | awk 'match($0, /.(\w+)$/, m) {print m[1]}')
  base=$(basename $f .$ext)
  mkdir -p $base
done
