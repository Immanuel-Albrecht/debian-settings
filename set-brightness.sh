#!/bin/sh

whoami

echo "$@" | cat - > /sys/class/backlight/intel_backlight/brightness
