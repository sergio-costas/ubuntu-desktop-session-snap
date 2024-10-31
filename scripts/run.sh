#!/bin/sh
export PULSE_SERVER=unix:/run/user/`id -u`/pulse/native
export WAYLAND_DISPLAY=/run/user/`id -u`/wayland-0
export XDG_SESSION_TYPE=wayland
exec "$@"
