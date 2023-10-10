#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally

player_status=$(playerctl -p spotify status 2>&1 | tr -d '\r')
if [[ "$player_status" != "No players found" ]]; then
    metadata="$(playerctl -p spotify metadata title) - $(playerctl -p spotify metadata artist)"
fi

if [[ $player_status = "Playing" ]]; then
    echo " $metadata"
elif [[ $player_status = "Paused" ]]; then
    echo " $metadata"
else
    echo ""
fi
