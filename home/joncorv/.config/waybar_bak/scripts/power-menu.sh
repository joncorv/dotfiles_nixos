#!/usr/bin/env bash

## Power menu options
shutdown="⏻ Shutdown"
reboot="⟳ Reboot"
suspend="⏾ Suspend"
logout="⏼ Logout"

# Show rofi menu
chosen=$(echo -e "$shutdown\n$reboot\n$suspend\n$logout" | rofi -dmenu -i -p "Power Menu" -theme ~/.config/rofi/themes/rounded-purple-dark.rasi)

case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $suspend)
        systemctl suspend
        ;;
    $logout)
        hyprctl dispatch exit
        ;;
esac
