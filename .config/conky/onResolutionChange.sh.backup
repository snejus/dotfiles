#!/bin/bash

kill $( top -bn1 | grep "conky$" | awk '{print $1}' )
kill $( top -bn1 | grep "xeventbind$" | awk '{print $1}' )

bash ~/.config/conky/launchConky.sh