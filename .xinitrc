if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ "$(hostname)" = "Vorringia" ]; then
    xrandr --output DVI-I-1 --auto --output DVI-I-2 --auto --right-of DVI-I-1;
fi

xrdb .Xresources
xset -b
xsetroot -cursor_name left_ptr

xkbcomp .keycomp.xkb $DISPLAY

pulseaudio --start &
xbindkeys
eval `cat ~/.fehbg`
exec /home/emallson/.cabal/bin/xmonad
