#!/bin/bash
#mplayer ~/audio/winsounds/Microsoft\ Windows\ 95\ Startup\ Sound.wav &
#xset +fp /usr/share/fonts &
#xset fp rehash &
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &
xrdb ~/.Xresources
xsetroot -cursor_name left_ptr
export BROWSER=firefox &
export LANG=en_US.UTF-8 &
sh ~/.fehbg &
xmodmap ~/.xmodmap &
xbindkeys &
nm-applet &
#sudo chmod 666 /sys/class/leds/tpacpi\:\:thinklight/brightness &
dunst &
compton &
urxvtd -q -f -o &
xset b off &
xautolock -corners 000- -cornersize 225 -time 15 -locker /home/ifs/scripts/xautolock.sh &
eval "$(gpg-agent --daemon)"
exec i3
