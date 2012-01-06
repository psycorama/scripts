#!/bin/bash
#
# switches keyboard layout before activating screensaver
# and switches back after succesfull authentification
#
/home/geisenhainer/scripte/keyboard_settings.sh us
xlock -mode matrix
/home/geisenhainer/scripte/keyboard_settings.sh neo
