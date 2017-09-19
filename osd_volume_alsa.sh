#!/bin/bash
#
# change volume for pulseaudio via shortcuts
#
# $1 -> +/-

# change volume
volume=$(amixer set Master 1dB${1}|grep "Front Left:"|cut -d "[" -f 2 |cut -d "%" -f 1)

# printing volume slider onto X
osd_cat -p bottom -A center -o 30 -c green -d 1 -s 1 -f -misc-fixed-*-*-*-*-18-* --barmode=slider --percentage=$volume &
