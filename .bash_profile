#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
# Initialization for FDK command line tools.Wed Oct 22 12:38:20 2014
FDK_EXE="/home/emallson/bin/FDK/Tools/linux"
PATH=${PATH}:"/home/emallson/bin/FDK/Tools/linux"
export PATH
export FDK_EXE
