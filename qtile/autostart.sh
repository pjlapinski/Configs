#!/bin/sh

nitrogen --restore &
picom -b -f &
caffeine &

xrandr --output DP-0 --primary --mode 1920x1080 --rate 144.00 --right-of HDMI-0
xrandr --output HDMI-0 --mode 1920x1080 --rate 60.00
