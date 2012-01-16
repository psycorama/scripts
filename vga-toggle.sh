#!/bin/sh
#
# screen layout and resolution chooser
# map this script to a special Laptop key (Fn+F7 on my Thinkpad)
#
# generic hints
# xvattr -a XV_CRTC -v {-1,0,1}
#
CHOOSE=$( zenity --list --column SHORT --column LONG --text "choose display settings" \
LVDS      "only internal" \
home_basis "@home [1600x1200]" \
home_above "@home [ 1600x1200] above" \
VGA       "only VGA" \
CLONEVGA  "clone internal + VGA" \
VGA_SXGA  "Vga mit 1280_1024 above LVDS" \
VGA_above "VGA ueber LVDS" \
VGA_right "VGA rechts von LVDS" \
VGA_left  "VGA links von LVDS" \
VGA_below "VGA unter LVDS" \
VGA_XGA   "VGA auf 1024x768 and clone" \
VGA_SVGA  "VGA auf 800x600 and clone" \
VGA_VGA   "VGA auf 640x480 and clone" \
VGA_UXGA  "VGA auf 1600x1200 and Clone" \
)

case $CHOOSE in

    LVDS)
	xrandr --output LVDS  --mode 1024x768 \
               --output VGA-0 --off --auto
	;;
 
    home_basis)
# single screen
	xrandr --output VGA-0 --mode 1600x1200 --output LVDS --off
	;;

    home_above)
# dual screen
	xrandr --output VGA-0 --above LVDS --mode 1600x1200 --auto
	;;

    CLONEVGA)
	xrandr --output LVDS    --mode 1024x768 \
               --output VGA-0   --mode 1024x768 --auto
	;;

    VGA)
	xrandr --output LVDS --off \
	      --output VGA-0 --auto
	;;

    VGA_above)
	xrandr --output VGA-0 --above LVDS --auto;
	;;

    VGA_left)
	xrandr --output VGA-0 --left-of LVDS --auto;
	;;

    VGA_right)
	xrandr --output VGA-0 --right-of LVDS --auto;
	;;

    VGA_above)
	xrandr --output VGA-0 --below LVDS --auto;
	;;

    VGA_XGA)
	xrandr --output VGA-0 --mode 1024x768 --auto 
	;;

    VGA_SVGA)
	xrandr --output VGA-0 --mode 800x600 --auto 
	;;

    VGA_VGA)
	xrandr --output VGA-0 --mode 640x480 --auto 
	;;
    
    VGA_SXGA)
	xrandr --newmode SXGA 109.00  1280 1368 1496 1712  1024 1027 1034 1063 -hsync +vsync
	xrandr --addmode VGA-0 SXGA 
	xrandr --output VGA-0 --above LVDS --mode SXGA --auto
	;;
    
    VGA_UXGA)
	xrandr --output VGA-0 --above LVDS --mode 1600x1200 --auto
	;;
esac
