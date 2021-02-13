#!/bin/bash

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && [[ $(systemctl --user is-system-running) == running ]]; then
    export DISPLAY=:0
    export XAUTHORITY=$HOME/.Xauthority
    dbus-update-activation-environment DISPLAY XAUTHORITY
    systemctl --user import-environment DISPLAY PATH XAUTHORITY GPG_TTY MPD_HOST NOTMUCH_CONFIG FONTCONFIG_PATH
    systemctl --user start awesomex-session.target
fi

