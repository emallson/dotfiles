xrdb .Xresources
xset -b
xsetroot -cursor_name left_ptr

xkbcomp ~/.keycomp.xkb $DISPLAY

xbindkeys
eval `cat ~/.fehbg`
source .profile
