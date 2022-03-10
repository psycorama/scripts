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
    echo "unable to find ID for HUGE in xinput. skipping"
else
    ###  ELECOM Huge button map ###
    # 1 left click
    # 2 middle click
    # 3 right click
    # 4/5/6/7 mouse wheel up/down/left/right
    # 8/9 forward/backward
    # 10/11/12 Fn1/Fn2/Fn3

    # remap Fn1 to left and Fn2 to middle click (10->1, 11->2)
    #xinput set-button-map "${MOUSE_DEV_ID}" 1 2 3 4 5 6 7 8 9 1 2 12

    # remap map:
    # Fn1/Fn2 -> forward/backward
    # right click -> left click
    # Fn3 -> right click,
    # forward -> middle-click
    # backward -> btn_12
    xinput set-button-map "${MOUSE_DEV_ID}" 1 2 1 4 5 6 7 12 2 9 8 3

    # reduce pointer speed
    xinput set-prop "${MOUSE_DEV_ID}" "libinput Accel Speed" -0.6

    # enable scrolling by pressing btn_forward(9) and moving the ball
    # normal function for btn_forward is not impeded
    xinput set-prop "${MOUSE_DEV_ID}" "libinput Scroll Method Enabled"   0, 0, 1
    xinput set-prop "${MOUSE_DEV_ID}" "libinput Button Scrolling Button" 9
    xinput set-prop "${MOUSE_DEV_ID}" "libinput Natural Scrolling Enabled" ${NATURAL_SCROLL}


    # modify scroll speed
    #xinput set-prop "${MOUSE_DEV_ID}" "Coordinate Transformation Matrix" 0.5, 0, 0, 0, 0.5, 0, 0, 0, 0.5
fi

# more standard thumb operated TrackBall Elecom EX-G
MOUSE_NAME="ELECOM ELECOM TrackBall Mouse"
MOUSE_TYPE="pointer"
MOUSE_DEV_ID=$(xinput list |grep "${MOUSE_NAME}" | grep "${MOUSE_TYPE}" | cut -d '=' -f 2 | cut -c 1-2)

if [ -z "${MOUSE_DEV_ID}" ]; then
    echo "unable to find ID for EX-G in xinput. skipping"
else
    ### ELECOM EX-G button map ###
    # 1/2/3 left/middle/right click
    # 4/5/6/7 mouse wheel up/down/left/right
    # 8/9 backward/forward
    # 10 button right of right click

    # reduce pointer speed
    xinput set-prop "${MOUSE_DEV_ID}" "libinput Accel Speed" -1

    # enable scrolling by pressing extra_button(10) and moving the ball
    xinput set-prop "${MOUSE_DEV_ID}" "libinput Scroll Method Enabled"   0, 0, 1
    xinput set-prop "${MOUSE_DEV_ID}" "libinput Button Scrolling Button" 10
    xinput set-prop "${MOUSE_DEV_ID}" "libinput Natural Scrolling Enabled" ${NATURAL_SCROLL}
fi

