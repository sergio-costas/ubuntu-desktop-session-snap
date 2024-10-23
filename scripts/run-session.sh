#!/bin/sh

# If xdg-user-dirs-update exists in $PATH, run it
if command -v xdg-user-dirs-update >/dev/null; then
  xdg-user-dirs-update
fi

# Ensure socket directories exist and have the right permissions
mkdir -p /tmp/.X11-unix /tmp/.ICE-unix
chmod 01777 /tmp/.X11-unix /tmp/.ICE-unix

# Create the runtime directory
mkdir -p --mode=700 $XDG_RUNTIME_DIR

USERPATH=/run/user/`id -u`

export PULSE_SERVER=unix:$USERPATH/pulse/native
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export WAYLAND_DISPLAY=$USERPATH/wayland-0

if ! grep "^snap$" $HOME/.hidden 2>&1 > /dev/null; then
  echo "snap" >> $HOME/.hidden
fi

export XDG_DATA_DIRS=${XDG_DATA_DIRS:+$XDG_DATA_DIRS:}$SNAP/usr/share
export PATH=${PATH:+$PATH:}$SNAP/usr/bin

# if [ ! -f $USERPATH/wayland-0 ]; then
#   ln -s $USERPATH/snap.ubuntu-desktop-session/wayland-0 $USERPATH/wayland-0
# fi

# if [ ! -f $USERPATH/pulse ]; then
#   ln -s $USERPATH/snap.ubuntu-desktop-session/pulse $USERPATH/pulse
# fi

exec $SNAP/usr/bin/gnome-shell --display-server --wayland
#exec $SNAP/usr/bin/gnome-session --builtin --session=ubuntu 2> ~/output2.txt > ~/output.txt
