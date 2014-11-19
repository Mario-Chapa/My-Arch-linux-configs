#!/usr/bin/zsh

orientation=$(xrandr | grep LVDS1 | awk //'{print $4}')

if [[ "$orientation" == "left" ]] then
	echo "true" > /home/mario/.custom/scr_vert
else
	echo "false" > /home/mario/.custom/scr_vert
fi

