#!/bin/sh
#
# change volume for FreeBSD alsa mixer via shortcuts
#
# $1 -> +/-

# get volume
volume=$(mixer | grep vol| cut -d ':' -f 2)

# calculate new volume (+/- 2%)
volume=$(( ${volume} ${1} 2 ))

if [ $volume -gt 100 ]; then
    volume=$((100))
elif [ $volume -lt 0 ]; then
    volume=$((0))
fi

# change volume
mixer vol ${volume} pcm ${volume}

# printing volume slider onto X
osd_cat -p bottom -A center -o 30 -c green -d 1 -s 1 -f -misc-fixed-*-*-*-*-18-* --barmode=slider --percentage=$volume &
