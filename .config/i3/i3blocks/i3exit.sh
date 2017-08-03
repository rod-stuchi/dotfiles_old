#!/bin/sh
# https://gist.github.com/zerosign/9948283
lock() {
    i3lock
}

case "$1" in
    lock)
		#$HOME/.config/i3/lockfull
        xautolock -locknow
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        #$HOME/.config/i3/lockfull &! systemctl suspend
        #terminator &! vlc #systemctl suspend
        xautolock -locknow &! systemctl suspend
        ;;
    hibernate)
		#$HOME/.config/i3/lockfull &! systemctl hibernate
        xautolock -locknow &! systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
