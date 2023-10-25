Keyboard shortcuts to switch layout

```
dconf read /org/gnome/desktop/input-sources/xkb-options

dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:alt_shift_toggle']"

dconf reset /org/gnome/desktop/input-sources/xkb-options

dconf read /org/gnome/desktop/input-sources/xkb-options
```
