#! /bin/sh
# echo ">>>> ${@: -2:1}" # lê penultimo valor

# useful references
# https://unix.stackexchange.com/a/331530
# http://mywiki.wooledge.org/BashFAQ/035

qr() {
  feh=0
  size=5
  margin=5
  verbose=0

  die() {
    printf '%s\n' "$1" >&2
  }

  help() {
    echo "
    usage:

    -h, --help      show this help
    -s, --size      specify module size in dots (pixels). (default=5)
    -m, --margin    specify the width of the margins. (default=5)
    -o, --open      open in feh (if available)
    -v, --verbose   verbose mode
 "
  }

  while :; do
    case $1 in
      -h|-\?|--help)
        help
        return 0;
        ;;
      -s|--size)
        if [ "$2" ]; then
          size=$2
          shift 2
        else
          die 'ERROR: "--size" requires an non-empty value.'
          return 1
        fi
        ;;
      -m|--margin)
        if [ "$2" ]; then
          margin=$2
          shift 2
        else
          die 'ERROR: "--margin" requires an non-empty value.'
          return 1
        fi
        ;;
      -o|--open)
        feh=1
        shift
        ;;
      -v|--verbose)
        verbose=1
        shift
        ;;
      *)
        break;
    esac
    # shift
  done

  if [[ $verbose -eq 1 ]]; then
    echo "📏 size:  $size  🔲 margin: $margin"
    echo "🗒 text: " $*
  fi
  qrencode -s $size -m $margin -o /tmp/qrcode-output.png "$*" && \
    xclip -selection clipboard -t image/png -i /tmp/qrcode-output.png && \
    pgrep -x dunst >/dev/null && notify-send -u low "QR was copied." "$*"

  if [[ $feh -eq 1 ]]; then
    feh /tmp/qrcode-output.png & disown
  fi
}

