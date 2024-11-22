#!/usr/bin/env bash
#
# simple script for switching between 2 keyboard
# layouts. useful for training purposes.
# or to call whenever your system has some hickups
# and resets your usb devices ...
#
# Copyright 2012+ BSD-2-Clause psycorama@datenhalde.de
#
#
MODE=${1}
SERVER=$(echo ${DISPLAY}|grep -c 2)

if [ -z "${MODE}" ]; then
    if [ -e "/tmp/bone_${SERVER}" ]; then
        MODE="us"
    else
        MODE="bone"
    fi;
fi;

#disables bell
xset -b
#sets keyboard timout(ms) and repeat-rate(/s)
xset r rate 200 35
# set the mouse-options (speed, button remap)
"${HOME}/scripte/elecom_remap.sh"

NEO_PATH="${HOME}/scripte/neo"

if xinput --list | grep -q -e "imp tech tasta" -e "psycorama Alya"; then
    if [ -e "/tmp/bone_${SERVER}" ]; then
        rm "/tmp/bone_${SERVER}"
    fi

    setxkbmap de nodeadkeys

elif [ "${MODE}" == "bone" ]; then

    touch "/tmp/bone_${SERVER}"

    setxkbmap lv
    xmodmap "${NEO_PATH}/bone.xmodmap"
    # disable key auto-repeat, when using Right-Alt as compose
    # xset -r 48
elif [ "${MODE}" == "us" ]; then
    if [ -e "/tmp/bone_${SERVER}" ]; then
        rm "/tmp/bone_${SERVER}"
    fi

    setxkbmap us
    # put Compose-Key on Right-Alt
    # xmodmap -e 'keycode 108 = Multi_key'
    # enable key auto-repeat
    # xset r 48
fi
