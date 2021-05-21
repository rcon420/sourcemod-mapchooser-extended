# sourcemod-mapchooser-extended
Extended version of the SourceMod MapChooser  
2021 version with Dynamic Mapcycle support - changes the mapcycle on the fly based on game state. :) 

--------------------------

Before installing anything read Original Installation Guide - https://forums.alliedmods.net/showthread.php?t=156974 (But don't download plugins from there).

- I don't need Dynamic Mapcycle support?

Use this - https://github.com/Totenfluch/sourcemod-mapchooser-extended

--------------------------

What this version has changed?

- Modified mapchooser_extended.smx
- Modified nominations_extended.smx
- Added dynamic_mapcycle.smx
- Pre configured (If you don't like it simply edit configs :) )

All those changes are related to dynamic_mapcycle.smx.

--------------------------

How to install dynamic_mapcycle? (Note: everything is pre configured in this repo already.)


------

1. Go to sourcemod/configs/maplists.cfg and edit "default"

2. Replace  "target" to   "file"  & replace "mapcyclefile" to  "addons/sourcemod/data/tmp_maplist.txt" 
// the plugin generates a mapcycle acording to the server state, the generated file is stored at this directory

4. Edit configs/mapchooser_extended/dynamic_mapcycle.cfg how you like. 

- dynamic_mapcycle.cfg has all the instrusctions how to use it. 

------

