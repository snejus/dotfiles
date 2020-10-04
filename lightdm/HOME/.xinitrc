#!/bin/sh

# [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

dbus-update-activation-environment --systemd --verbose DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
MPD_HOST=/run/user/1000/mpd/socket && exec awesome
# DISPLAY=${DISPLAY} exec dbus-run-session -- awesome
# export $(dbus-launch --exit-with-session ) & exec awesome


