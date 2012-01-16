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
    if [ -e /tmp/neo ]; then
	MODE="us"
    else
	MODE="neo"
    fi;
fi;

#disables bell
xset -b
#sets keyboard to 250ms timeout 30chars/s
xset r rate 250 30
#sets mouse to acceleration 2 with 30 timeout
xset m 2 30

NEO_PATH=$HOME/scripte/neo

if [ "$MODE" == "neo" ]; then
    touch /tmp/neo
    if [ -n "`xinput --list |grep \"imp tech tasta\"`" ]; then
	setxkbmap de nodeadkeys
    else
	setxkbmap lv
	xmodmap $NEO_PATH/neo_de.xmodmap
    fi;
    xset -r 51

    if [ -z "`pidof neo_layout_viewer`" ]; then
	#start view helper
	cd $NEO_PATH/ && ./neo_layout_viewer &
    fi;
elif [ "$MODE" == "us" ]; then  
    if [ -e /tmp/neo ]; then
	rm /tmp/neo
    fi;
    setxkbmap us
    xset r 51
    # put Compose-Key on Right-Alt
    xmodmap -e 'keycode 108 = Multi_key'
    
    #put Control on CapsLock
    #xmodmap -e 'keycode 66 = Control_L'
    #xmodmap -e 'clear Lock'
    #xmodmap -e 'add Control = Control_L'

elif [ "$MODE" == "off" ]; then
    if [ -n "`pidof neo_layout_viewer`" ]; then
	killall neo_layout_viewer;
    fi;
fi;
