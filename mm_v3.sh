#!/bin/bash

MID=`xinput list|grep "Logitech USB Optical Mouse"|cut -f 2|cut -c 4-`

if [ -n $MID ]; then
    xinput --set-prop $MID "Device Accel Constant Deceleration" 1.5
    xinput --set-prop $MID "Device Accel Adaptive Deceleration" 5.0
    xinput --set-prop $MID "Device Accel Velocity Scaling" 2.0
    xinput --set-prop $MID "Evdev Axis Inversion" 0, 1
fi