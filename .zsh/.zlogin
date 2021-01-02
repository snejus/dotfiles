#!/bin/bash

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && [[ $(systemctl --user is-system-running) == running ]]; then
    export DISPLAY=:0
    dbus-update-activation-environment DISPLAY
    systemctl --user import-environment DISPLAY PATH
    systemctl --user start awesomex-session.target
else
    doge
fi

