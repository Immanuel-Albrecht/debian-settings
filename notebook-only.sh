#!/bin/sh

xrandr --output eDP-1 --auto --scale 1x1

cat - <<EOF | xrdb -merge /dev/stdin
Xft.dpi: 70
Xft.autohint: 0
Xft.lcdfilter:  lcddefault
Xft.hintstyle:  hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgb
EOF

touch $HOME/.notebook-only-sh
