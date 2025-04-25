#!/usr/bin/env bash
#
# change volume for pipewire via shortcuts
#
# $1 -> +/-

# set volume +/- 2%
wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%${1}
# get volume
volume=$( wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}' )
volume=${volume/./}

# printing volume slider onto X
osd_cat -p bottom -A center -o 30 -c green -d 1 -s 1 -f -misc-fixed-*-*-*-*-18-* --barmode=slider --percentage=${volume} &
