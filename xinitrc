#!/bin/sh
echo "Loading $HOME/.xinitrc"

sysres=/etc/X11/xinit/.Xressources
usrres=$HOME/.Xressources
usrmod=$HOME/.Xmodmap

bepo=$HOME/.bepo/
#wm=/usr/local/bin/openbox-session
wm=/usr/bin/fluxbox

echo "Turning off beep"
xset b off

echo "Loading keymap"
setxkbmap fr -variant bepo

echo "Loading xmodmap"
[ -f $usrmod ] && xmodmap $usrmod

echo "Reseting keyboard repeatition rate"
xset r rate 500 30

echo "Loading resources"
[ -f $sysres ] && xrdb $sysres
[ -f $usrres ] && xrdb $usrres

echo "Loading urxvt-deamon"
urxvtd -q -f -o

echo "Starting `basename $wm`"
$wm  &
pid=$!

# Note about loading a keymap:
# As launching xkbcomp before $wm will have no effect, we have to cheat
# a little :
# time=5
# sleep $time && xkbcomp -w0 "$bepo/fr-dvorak-bepo.xkb" $DISPLAY &
# But that's not pretty beautiful. We can use xmodmap instead: if you don't
# have a xmodmap (bepo) file, just start a X, load your xkb file, and use
# xmodmap -pke > xmodmap_file to generate it. Then, just load it with:
# xmodmap $file.
# The only problem with this method, is that, for a bepo keymap, it
# sux with alt-gr...
# [ -f $usrmod ] && xmodmap $usrmod
# Note that the window manager have to be "fully" loaded so that setting the
# keymap with xkbcomp won't sux, so launching it just after loading the wm
# won't have no effects.

wait $pid
