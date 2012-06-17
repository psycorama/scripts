#!/bin/bash
#
# change volume for pulseaudio via shortcuts
#
# $1 -> +/-

# Find default sink
sink=`pacmd info|grep "Default sink name"|awk '{print $4}'`

# get volume
volume=`pacmd list-sinks|grep "volume: 0:"|cut -d " " -f 4|sed -e 's/%//'`

# calculate new volume (+/- 2%)
volume=$((volume $1 2 ))

# change volume
pactl set-sink-volume $sink "$volume%"

# printing volume slider onto X
osd_cat -p bottom -A center -o 30 -c green -d 1 -s 1 -f -misc-fixed-*-*-*-*-18-* --barmode=slider --percentage=$volume &
