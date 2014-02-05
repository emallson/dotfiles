setxkbmap -option ctrl:nocaps
xrdb .Xresources
xset -b
xsetroot -cursor_name left_ptr
setxkbmap us -variant colemak
pulseaudio --start &
/home/emallson/.root/bin/stumpwm
