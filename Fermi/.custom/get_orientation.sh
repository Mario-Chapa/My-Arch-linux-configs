#!/usr/bin/zsh

orientation=$(xrandr | grep LVDS1 | awk //'{print $4}')

if [[ "$orientation" == "left" ]] then
	return 1
else
	return 0
fi
