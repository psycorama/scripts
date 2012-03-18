#!/bin/bash
#
# switches keyboard layout before activating screensaver
# and switches back after succesfull authentification
#
$HOME/scripte/keyboard_settings.sh us
xlock -mode matrix
$HOME/scripte/keyboard_settings.sh bone
