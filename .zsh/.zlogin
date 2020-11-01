#!/bin/bash

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    export DISPLAY=:0
    export XAUTHORITY=$HOME/.Xauthority
    dbus-update-activation-environment DISPLAY XAUTHORITY
    systemctl --user import-environment DISPLAY XAUTHORITY
fi

