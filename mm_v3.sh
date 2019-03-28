#!/bin/bash

# TODO: find better method of differentiating input devices
if [ `xinput list | grep -c 'Logitech USB Optical Mouse'` -gt 0 ] ; then

    MOUSE="Logitech USB Optical Mouse"
    # find USB ID of input
    MID=`xinput list|grep -e "$MOUSE"|cut -f 2|cut -c 4-`

    if [ -n $MID ]; then
	xinput --set-prop $MID "Device Accel Constant Deceleration" 1.5
	xinput --set-prop $MID "Device Accel Adaptive Deceleration" 5.0
	xinput --set-prop $MID "Device Accel Velocity Scaling" 2.0
	xinput --set-prop $MID "Evdev Axis Inversion" 0, 1
    fi

elif [ `xinput list | grep -c 'Logitech Trackball'` -gt 0 ] ; then

    MOUSE="Logitech Trackball"
    # find USB ID of input
    MID=`xinput list|grep -e "$MOUSE"|cut -f 2|cut -c 4-`
    echo $MID
    if [ -n $MID ]; then
	xinput --set-prop $MID "Device Accel Constant Deceleration" 1.5
	xinput --set-prop $MID "Device Accel Adaptive Deceleration" 4.0
	xinput --set-prop $MID "Device Accel Velocity Scaling" 3.0
    fi
fi






