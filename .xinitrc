setxkbmap -layout us,ru -option grp:alt_shift_toggle
xset r rate 200 35
xsetroot -solid '#1a1a1a'
dunst &
clipmenud &
slstatus &
~/.local/bin/sunset.sh &

picom --no-fading-openclose --animations=none
xrandr --output HDMI-A-1 --mode 2560x1440 --pos 1920x0 --output eDP-1 --mode 1920x1200 --pos 0x0 --primary

xinput set-prop "ELAN2611:00 04F3:31DC Touchpad" "libinput Natural Scrolling Enabled" 1 &
xinput set-prop "ELAN2611:00 04F3:31DC Touchpad" "libinput Tapping Enabled" 1

export XDG_CURRENT_DESKTOP=dwm
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP

exec dwm
