#!/bin/sh

# [[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

dbus-update-activation-environment --systemd --verbose DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
export $(gnome-keyring-daemon --daemonize) MPD_HOST=/run/user/1000/mpd/socket && exec awesome


