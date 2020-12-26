#!/bin/bash

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && [[ $(systemctl --user is-system-running) == running ]]; then
    export DISPLAY=:0
    export XAUTHORITY=$HOME/.Xauthority
    dbus-update-activation-environment DISPLAY XAUTHORITY
    systemctl --user import-environment DISPLAY XAUTHORITY PATH
    systemctl --user start awesomex-session.target
else
    doge
fi

