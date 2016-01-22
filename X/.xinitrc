#!/bin/zsh
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb .Xresources
xset -b
xsetroot -cursor_name left_ptr

setxkbmap -option control:nocaps -option compose:prsc

xbindkeys
sh ~/.fehbg &

DISP_NUM=${DISPLAY/:/}
systemctl --user start redshift@$DISP_NUM touchegg@$DISP_NUM

#sshfs -o reconnect amos.csr.uky.edu: ~/Remotes/csr &
#sshfs -o reconnect vulture.csr.uky.edu:/u/vul-d1/scratch/emallson ~/Remotes/scratch/vulture &

if [[ "$HOST" == "Rubi-Ka" ]]; then
   xmodmap .xmodmaprc
fi

xautolock -locker "i3lock -n" -time 5 -secure &

# exec i3 -V >> ~/.i3log-$(date +'%F-%k-%M-%S') 2>&1
exec xmonad
