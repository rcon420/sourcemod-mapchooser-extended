# sourcemod-mapchooser-extended

MapChooser Extended  2021 version with Dynamic Mapcycle support - changes the mapcycle on the fly based on the game state. :) 

--------------------------

Before installing anything read Original Installation Guide - https://forums.alliedmods.net/showthread.php?t=156974 (But don't download plugins from there).

- I don't need Dynamic Mapcycle support?

Use this - https://github.com/Totenfluch/sourcemod-mapchooser-extended

--------------------------

What this version has changed?

- Modified mapchooser_extended plugin
- Modified nominations_extended plugin
- Added new dynamic_mapcycle plugin
- Github repo pre-configured (If you don't like it simply edit/remove configs  )

All those changes are related to dynamic_mapcycle

TL;DR in human language - you can have map votes based on current server time, day of week & player count also it's excludes map from nomination menu if they cant be played with this modified map chooser extended version.

--------------------------

How to install dynamic_mapcycle? (Note: everything is pre-configured in the repo already.)


------

1. Go to sourcemod/configs/maplists.cfg and edit "default"

2. Replace "target" to "file" & replace "mapcyclefile" to "addons/sourcemod/data/tmp_maplist.txt"

(The plugin generates a mapcycle according to the server state, the generated file is stored at this directory)

4. Edit configs/mapchooser_extended/dynamic_mapcycle.cfg how you like.

- dynamic_mapcycle.cfg has all the instructions on how to use it.

- for compiling use 1.7 or 1.8 sm because map chooser extended is quite old & needs to be rewritten.

------

No future updates planned yet. 

