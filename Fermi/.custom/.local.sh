# R related
alias R='R --quiet'
R_LIBS=~/.data/Rpackages/

# trackinvertaxis
# alias trackinvertaxis='xinput set-int-prop "Kensington Kensington Slimblade Trackball" "Evdev Axis Inversion" 8 1 1'

## Quick cd aliases
alias cdredux='cd /home/mario/Programming/SHOC/src/opencl/level1/reduction'

# easy archy shutdown after sync.
alias archyoff="ssh -t Archy 'systemctl poweroff'"
alias SyncPoweroff='unison research;archyoff'

#youtube dl stuff
alias yt-audio='youtube-dl -f bestaudio -x --no-playlist'
alias yt-video='youtube-dl -f bestvideo --no-playlist'

alias cpucheckfreq 'cat /proc/cpuinfo gp MHz'
alias cpusetperf 'sudo cpupower frequency-set -g performance'
alias cpusetsave 'sudo cpupower frequency-set -g powersave'
alias cpuwatchfreq "watch grep \'cpu MHz\' /proc/cpuinfo"
## name=\c[q6]verga\c[q8].\c[g5]tron\c-
