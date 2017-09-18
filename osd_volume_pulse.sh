#!/bin/bash
#
# change volume for pulseaudio via shortcuts
#
# $1 -> +/-

# Find default sink
sink=`pacmd info|grep "Default sink name"|awk '{print $4}'`

# get volume
#volume=`pacmd list-sinks|grep -A 6 $sink|tail -1|cut -c 13-15`
volume=$( pacmd list-sinks|grep -A 6 $sink|tail -1)
volume=$( echo $volume| cut -d ' ' -f 5 )

# calculate new volume (+/- 2%)
volume=$[ ${volume%%\%} $1 2 ]

if [ $volume -gt 100 ]; then
    volume=$((100))
elif [ $volume -lt 0 ]; then
    volume=$((0))
fi

# change volume
pactl set-sink-volume $sink "$volume%"

# printing volume slider onto X
osd_cat -p bottom -A center -o 30 -c green -d 1 -s 1 -f -misc-fixed-*-*-*-*-18-* --barmode=slider --percentage=$volume &
