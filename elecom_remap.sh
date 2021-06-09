#!/usr/bin/env bash

if [ -z  "$(command -v xinput)" ]; then
    echo " 'xinput' not found. bailing …"
    exit 8
fi

NATURAL_SCROLL=0
if [ -n "${1}" ] && [ "${1}" = "-n" ]; then
    NATURAL_SCROLL=1
fi

MOUSE_NAME="ELECOM TrackBall Mouse HUGE TrackBall"
MOUSE_TYPE="pointer"

MOUSE_DEV_ID=$(xinput list |grep "${MOUSE_NAME}" | grep "${MOUSE_TYPE}" | cut -d '=' -f 2 | cut -c 1-2)

if [ -z "${MOUSE_DEV_ID}" ]; then
    echo "unable to find ID for mouse in xinput. bailing"
    exit 9
fi

###  ELECOM Huge button map ###
# 1 left click
# 2 middle click
# 3 right click
# 4/5/6/7 mouse wheel up/down/left/right
# 8/9 forward/backward
# 10/11/12 Fn1/Fn2/Fn3

# remap Fn1 to left and Fn2 to middle click (10->1, 11->2)
#xinput set-button-map "${MOUSE_DEV_ID}" 1 2 3 4 5 6 7 8 9 1 2 12

xinput set-button-map "${MOUSE_DEV_ID}" 1 2 1 4 5 6 7 12 2 9 8 3

# enable scrolling by pressing btn_forward(9) and moving the ball
# normal function for btn_forward is not impeded
xinput set-prop "${MOUSE_DEV_ID}" "libinput Scroll Method Enabled"   0, 0, 1
xinput set-prop "${MOUSE_DEV_ID}" "libinput Button Scrolling Button" 9
xinput set-prop "${MOUSE_DEV_ID}" "libinput Natural Scrolling Enabled" ${NATURAL_SCROLL}


# modify scroll speed
#xinput set-prop "${MOUSE_DEV_ID}" "Coordinate Transformation Matrix" 0.5, 0, 0, 0, 0.5, 0, 0, 0, 0.5
