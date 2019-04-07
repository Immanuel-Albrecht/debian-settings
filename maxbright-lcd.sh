#!/bin/sh

sudo /usr/local/bin/set-brightness.sh `cat /sys/class/backlight/intel_backlight/max_brightness `
