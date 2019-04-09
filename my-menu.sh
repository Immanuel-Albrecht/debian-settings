#!/bin/sh

EXEC=$(dmenu <<EOF
false
gnome-control-center
chromium
nautilus
EOF
)

echo $EXEC
$EXEC
