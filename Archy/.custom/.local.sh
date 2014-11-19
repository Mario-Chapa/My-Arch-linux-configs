### Networking aliases  #############################################
#alias lanup='sudo ip link set wlp2s0 up'
#alias langetip='sudo dhcpcd'

#alias wlanscan='sudo iw dev wlp2s0 scan'
#alias wlanfindSSID='sudo iw dev wlp2s0 scan | grep SSID'
#alias wlancheck='sudo iw dev wlp2s0 link'

#alias wlanhowto_WEP='echo "sudo iw dev wlp2s0 connect [SSID] key 0:[pass]"'
#alias wlanhowto_genWPAconfig='echo "wpa_passphrase [SSID] [pass] > .wpas_configs/{filename}.conf"'
#alias wlanhowto_bindWPA='echo "sudo wpa_supplicant -B -i wlp2s0 -c .wpas_configs/{filename}.conf"'

#alias ligthsoff='xbacklight -dec 100'
#alias backlightup='xbacklight -inc 10'
#alias backlightdown='xbacklight -dec 10'

alias kblatam='setxkbmap -layout latam'
# alias kbjp='setxkbmap -layout jp'
# alias scrvertical='xrandr --output LVDS1 --rotate left'
# alias scrnormal='xrandr --output LVDS1 --rotate normal'
# alias capslockkill='xmodmap ~/.Xmodmap'
#alias bkligth='sudo nano /sys/class/backlight/intel_backlight/brightness'

# Wireless stuff here
# source ~/.bin/FUN_alias_file.sh
# alias wlangen='. ~/bin/wlangen'