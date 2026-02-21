#!/usr/bin/env bash

if [[ $1 == "open" ]]; then
    hyprctl keyword monitor "eDP-1, 3840x2400@59.994, auto, 2"
elif [[ $1 == "close" ]]; then
    if hyprctl monitors | grep -q "DP-"; then
        hyprctl keyword monitor "eDP-1, disable"
    fi
elif [[ $1 == "init" ]]; then
    # Check if lid is currently closed
    if grep -q "closed" /proc/acpi/button/lid/LID0/state 2>/dev/null || \
       grep -q "closed" /proc/acpi/button/lid/LID/state 2>/dev/null; then
        if hyprctl monitors | grep -q "DP-"; then
            hyprctl keyword monitor "eDP-1, disable"
        fi
    fi
fi
