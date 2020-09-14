#!/bin/sh

dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
export $(gnome-keyring-daemon --daemonize) && exec awesome


