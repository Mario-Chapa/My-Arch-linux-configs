# Misc arch linux config files #
This are my most important configuration files in my 2 computers, both of them running arch linux with awesomewm. Fermi is my desktop pc and archy is my netbook (screw tablets, they suck[who the hell can live without a phisical keyboard?? D:]).
I mainly set up this repo as a backup for my files, but I have been working over some time on the files gathering a couple of tricks and I though that someone migth find something interesting. If you happen to arrive to this page and find something useful, please help yourself :)

## Awesome WM files ##
If you use awesomewm, you migth find some inspiration here. My current rc.lua and theme.lua files have evolved some 1.5 years and among other things they include:
+ Simple minimalist design, minimal clock, 5 tags, cpu usage graph. No menu, cause I dont use mouse, instead, see the next item:
+ Win+p to pop-up a open clients menu. uses vi-like _j,k_ to move up/down and _f_ to select program. Move around your opened task without leaving the home row.
+ A simple wallpaper randomizer, just write the files you want to use as wallpaper in the theme.lua wallpaper list and thats it, the function in the rc.lua will chose one at random and set it as wallpaper
+ run_once function, to prevent multiple instances of a program from running when constantly restarting awesomewm
+ poweroff, reboot, suspend keybindings using systemctl, the rigth way to do it

## Conkyrc file ##
My conky is simplicity overload, only useful stuff, nothing more

## Sublime text files ##
My User files for sublime (I am using Subl 3). nothing too impresive there, some snippets for latex bibtex, a macro to correct Enter in vintage mode and a couple of tricks in the keybinds
I also use a modified solarize color scheme, the background is darker and some other color adjustments, plus I added several missing fields which improves a little bit the syntax highligthing. Its name NaviSolarized.

## Zsh shell customization files ##
Simple custom prompt, home-cluster key enabled, menu, completion for everything among other stuff. some alias and functions you migth find interesting.

Feel free to browse around and grab anything you find useful/interesting :)