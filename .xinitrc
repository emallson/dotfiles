if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ "$(hostname)" = "Vorringia" ]; then
    xrandr --setprovideroutputsource 1 0;
    xrandr --output DVI-I-1 --auto --output DVI-I-1-3 --auto --right-of DVI-I-1;
fi

setxkbmap -option ctrl:nocaps
xrdb .Xresources
xset -b
xsetroot -cursor_name left_ptr
setxkbmap us -variant colemak
pulseaudio --start &
/home/emallson/.root/bin/stumpwm
