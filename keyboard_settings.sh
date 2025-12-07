#!/usr/bin/env bash
#
# simple script for switching between 2 keyboard
# layouts. useful for training purposes.
# or to call whenever your system has some hickups
# and resets your usb devices ...
#
# 2012+ BSD-2-Clause psycorama@datenhalde.de
#

# TODO: finish documentation, depends, variables
MODE=$1

if [ -z "${MODE}" ]; then
    if [ -e "/tmp/bone_${SERVER}" ]; then
        MODE="de"
    else
       MODE="bone"
    fi
fi

#disables bell
xset -b
xset r rate 250 50

~/scripte/elecom_remap.sh

NEO_PATH="/home/andy/scripte/neo"
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

elif [ "${MODE}" == "us" -o "${MODE}" == "de" ]; then
    if [ -e "/tmp/bone_${SERVER}" ]; then
        rm "/tmp/bone_${SERVER}"
    fi

    setxkbmap "${MODE}"
    # put Compose-Key on Right-Alt
    # xmodmap -e 'keycode 108 = Multi_key'
    # xset r 48

fi
