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
# BTSX Ep 2
# '/usr/bin/zandronum' '-connect' '192.99.6.150:15140' '-iwad' '/home/mario/.zandronum/doom2.wad' '-file' '/home/mario/.doomseeker/btsx_e2a.wad' '-file' '/home/mario/.doomseeker/btsx_e2b.wad' '-file' '/home/mario/.doomseeker/btsxe2-cd-liquidpatch.v2.wad' '-file' '/home/mario/.doomseeker/complex-doom.v25b2.pk3' '-file' '/home/mario/.doomseeker/complex-classes-addon.v3a2.pk3' '-file' '/home/mario/.doomseeker/complex-doom-justammo.v3.wad' '-file' '/home/mario/.doomseeker/btsxe2-palette.wad' '-file' '/home/mario/.doomseeker/NewTextColours1_170.pk3' '+cl_hidecountry' '1'
# Valiant
# '/usr/bin/zandronum' '-connect' '192.99.6.150:15082' '-iwad' '/home/mario/.zandronum/doom2.wad' '-file' '/home/mario/.doomseeker/valiantrc2.wad' '-file' '/home/mario/.doomseeker/complex-doom.v25b2.pk3' '-file' '/home/mario/.doomseeker/complex-classes-addon.v3a2.pk3' '-file' '/home/mario/.doomseeker/cd-minigun-enhancement.wad' '-file' '/home/mario/.doomseeker/complex-doom-justammo.v3.wad' '-file' '/home/mario/.doomseeker/valiant-complexpatch.v3.wad' '-file' '/home/mario/.doomseeker/NewTextColours1_170.pk3' '+cl_hidecountry' '1'
# Stronghold
# '/usr/bin/zandronum' '-connect' '192.99.6.150:15042' '-iwad' '/home/mario/.zandronum/doom2.wad' '-file' '/home/mario/.doomseeker/strnghld_v1.pk3' '-file' '/home/mario/.doomseeker/strnghld_violence_v4.pk3' '-file' '/home/mario/.doomseeker/StrongHoldEditsNFixesv1.1PatchV4.1.pk3' '-file' '/home/mario/.doomseeker/StrongholdItemsV7.1.pk3' '-file' '/home/mario/.doomseeker/strongholduntitledpatchv1.66.pk3' '-file' '/home/mario/.doomseeker/NewTextColours1_170.pk3' '+cl_hidecountry' '1'