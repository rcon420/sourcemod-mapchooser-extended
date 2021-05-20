# sourcemod-mapchooser-extended
Extended version of the SourceMod MapChooser  
2021 forked version :) 

Original Installation Guide -

What this version has changed?

- Modified mapchooser_extended.smx
- Modified nominations_extended.smx
- Added dynamic_mapcycle.smx

All those changes are related to dynamic_mapcycle.smx.

What it does?

- Changes the mapcycle on the fly based on game state


How to install dynamic_mapcycle?

1. Go to sourcemod/configs/maplists.cfg and edit "default"

2. Replace  "target" to   "file"  & replace "mapcyclefile" to  "addons/sourcemod/data/tmp_maplist.txt" 
// the plugin generates a mapcycle acording to the server state, the generated file is stored at this directory

4. Edit configs/mapchooser_extended/dynamic_mapcycle.cfg how you like.

I will leave example later here:

