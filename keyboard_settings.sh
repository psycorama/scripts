#!/bin/bash
#
# simple script for switching between 2 keyboard
# layouts. useful for training purposes.
#
# Copyright 2012 GPL psycorama@opensecure.de
#
#
# TODO: finish documentation, depends, variables
MODE=$1

if [ -z "$MODE" ]; then
    if [ -e /tmp/bone ]; then
	MODE="us"
    else
	MODE="bone"
    fi;
fi;

#disables bell
xset -b
#sets keyboard to 250ms timeout 30chars/s
xset r rate 250 30
#sets mouse to acceleration 2 with 30 timeout
xset m 2 30

NEO_PATH=$HOME/scripte/neo

if [ "$MODE" == "bone" ]; then
    touch /tmp/bone

    setxkbmap lv
    xmodmap $NEO_PATH/bone.xmodmap
    xset -r 48

elif [ "$MODE" == "us" ]; then  
    if [ -e /tmp/bone ]; then
	rm /tmp/bone
    fi;

    if [ -n "`xinput --list |grep \"imp tech tasta\"`" ]; then
	setxkbmap de nodeadkeys
    else
	setxkbmap us
        # put Compose-Key on Right-Alt
	xmodmap -e 'keycode 108 = Multi_key'
    fi
    xset r 48
fi;
