#! /bin/bash

# rename file that contains subtitle to S{NUM}E{NUM}.ext
for sub in $(ls *.{zip,rar} 2> /dev/null | grep -v "^[sS][0-9]\{2\}[eE]"); do
  ext=$(echo $sub | awk 'match($0, /.(\w+)$/, m) {print m[1]}')
  case $ext in
    zip)
      d=$(7z l $sub | awk '/srt$/ { print $NF }' | head -n1)
      ;;
    rar)
      d=$(unrar l $sub | rg "^ -" | awk '/srt$/ { print $NF }' | head -n1)
      ;;
  esac
  read -r S E <<< $(echo $d | awk 'match($0, /([sS][0-9]+).*([eE][0-9]+)/, a) { print toupper(a[1]" "a[2]) }')
  mv $sub $S$E.$ext 2>/dev/null
done

# list names from folders
for d in $(ls -d */ | sed 's|/$||'); do
  # S => season
  # E => episode
  # P => resolution (720p | 1080p)
  # R => release
  read -r S E P R <<< $(echo $d | awk 'match($0, /([sS][0-9]+).*([eE][0-9]+).*(webrip|WEBRip|408p|720p|1080p).*-(\w+)(|\[\w+\])$/, a) { print toupper(a[1]" "a[2])" "a[3]" "a[4] }')

  if [[ ! -z $S ]]; then
    zfile=$(ls $S$E.{rar,zip} 2>/dev/null)
    if [[ ! -z $zfile ]]; then
      ext=$(echo $zfile | awk 'match($0, /.(\w+)$/, m) {print m[1]}')
      case $ext in
        zip)
          subfile=$(7z l $zfile | awk '/srt$/ { print $NF }' | rg -i "$S.*$E.*$P.*$R" | head -n1)
          printf " > 📂%s%s %6s %-8s - 🗄 %s \n" $S $E $P $R $(basename $subfile)
          7z -y e $zfile "$subfile" >/dev/null
          subfile=$(basename $subfile)
          ;;
        rar)
          subfile=$(unrar l $zfile | awk '/srt$/ { print $NF }' | rg -i "$S.*$E.*$P.*$R" | head -n1)
          printf " > 📂%s%s %6s %-8s - 🗄 %s \n" $S $E $P $R $(basename $subfile)
          unrar e -y $zfile "$subfile" >/dev/null
          ;;
      esac

      if [[ $? -eq 0 ]]; then
        full_path_media=$(ls "$d"/*.{mkv,mp4,avi} 2>/dev/null)
        ext=$(echo $full_path_media | awk 'match($0, /.(\w+)$/, m) {print m[1]}')
        media=$(basename $full_path_media .$ext)
        cp "$subfile" "$d"
        rm "$subfile"
        pushd "$d" >/dev/null
        cp "$subfile" "$media.srt" 2>/dev/null
        [[ $? = 0 ]] && rm "$subfile"
        printf "      - %s\n" $(ls *.{mkv,srt,avi,mp4} 2>/dev/null)
        echo ""
        popd >/dev/null
        # [[ $(ls "$d"/*.{mkv,srt,avi,mp4} 2>/dev/null | wc -l) -eq 2 ]] && rm $zfile
      fi
    fi
  fi
done
