#!/bin/sh

rm $HOME/.startup-sh

touch $HOME/.startup-sh

# set gnome hiDPI mode

$(dirname $0)/set_hidpi.sh

# Set hiDPI to X

cat - <<EOF | xrdb -merge /dev/stdin
Xft.dpi: 140
Xft.autohint: 0
Xft.lcdfilter:  lcddefault
Xft.hintstyle:  hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgb
EOF

sleep 3
if ! [ -z "$(xrandr | grep 'DP-1 disconnected')" ] ; then 
xrandr --output eDP-1 --scale "1.25x1.25" --primary --auto
else
	set -x 

MYMODE="$(xrandr | grep -A 1 '^DP-1 con' | tail -n 1 | awk '{print $1}')"
xrandr --output DP-1 --mode "$MYMODE" --primary --pos 0x0
LCDMODE="$(xrandr | grep -A 1 '^eDP-1 con' | tail -n 1 | awk '{print $1}')"
xrandr --output eDP-1 --mode "$LCDMODE" --scale "1.4x1.4" --right-of DP-1 --noprimary
MYMODE="$(xrandr | grep '^DP-1 con' | awk '{print $4}')"
LCDMODE="$(xrandr | grep '^eDP-1 con' | awk '{print $4}')"
LCDHEIGHT="$(xrandr | grep '^eDP-1 con' | awk '{print $3}' | tr 'x+' '  ' | awk '{print $2}')"
MYWIDTH="$(xrandr | grep '^DP-1 con' | awk '{print $3}' | tr 'x+' '  ' | awk '{print $1}')"
MYHEIGHT="$(xrandr | grep '^DP-1 con' | awk '{print $3}' | tr 'x+' '  ' | awk '{print $2}')"
LCDPOS="${MYWIDTH}x$(( MYHEIGHT - LCDHEIGHT ))" 
xrandr --output eDP-1 --pos "$LCDPOS"

fi


echo "done." >> $HOME/.startup-sh
