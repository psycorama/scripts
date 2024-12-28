#!/bin/sh
#
# screen layout and resolution chooser
# map this script to a special Laptop key (Fn+F7 on my Thinkpad)
#
# generic hints
# xvattr -a XV_CRTC -v {-1,0,1}
#

CHOOSE=$( yad --list --column SHORT --column LONG --text "choose display settings" \
              internal      "only internal" \
              wozi_dual     "@Wohnzimmer [internal]+[1440pUW]" \
              wozi_tripple  "@Wohnzimmer [internal]+[1440pUW]+[1440p]" \
              wozi_dual_right "@Wohnzimmer [1440pUW]+[1440p]" \
              wozi_single   "@Wohnzimmer only [1440pUW]" \
              lager_tripple "@Arbyteslager [internal+[1440p]+[1440p]" \
              lager_double  "@Arbyteslager [internal+[1440p]" \
)
CHOOSE=${CHOOSE/|*/}
case $CHOOSE in
    internal)
	    ~/.screenlayout/single.sh
	    ;;
    wozi_single)
        ~/.screenlayout/home_wozi_only1440p.sh
        ;;
    wozi_dual)
        ~/.screenlayout/home_wozi_int_plus_one.sh
        ;;
    wozi_dual_right)
        ~/.screenlayout/home_wozi_dual_noint.sh
        ;;
    wozi_tripple)
        ~/.screenlayout/home_wozi_itsa_tripple.sh
        ;;
    lager_tripple)
        ~/.screenlayout/home_labor_tripple.sh
        ;;
    lager_double)
        ~/.screenlayout/labor_double.sh
        ;;
esac
