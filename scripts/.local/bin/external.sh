#!/usr/bin/env bash
if [[ -z "$1" || "lab" = "$1" ]]; then
    xrandr --output LVDS1 --auto --pos 1050x780 --output HDMI1 --rotate left --auto --pos 0x0;
elif [[ "auto" = "$1" ]]; then
    xrandr --output LVDS1 --auto --output DP1 --left-of LVDS1 --auto;
elif [[ "hdmi" = "$1" ]]; then
    xrandr --output LVDS1 --auto --output HDMI1 --left-of LVDS1 --auto;
elif [[ "dup" = "$1" ]]; then
    xrandr --output LVDS1 --auto --output HDMI1 --auto;
elif [[ "off" = "$1" ]]; then
    xrandr --output LVDS1 --auto --output DP1 --off --output HDMI1 --off;
fi

source ~/.fehbg
