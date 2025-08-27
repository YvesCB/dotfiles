#!/bin/bash

#Options
options="Shutdown\nRestart\nSuspend\nLogout"

# Show options in wofi and get selected option
selected_option=$(echo -e "$options" | wofi -i --dmenu --prompt "Power Menu")

# Perform the selected action
case "$selected_option" in
    Shutdown) 
        systemctl poweroff
        ;;
    Restart) 
        systemctl reboot
        ;;
    Suspend) 
        systemctl suspend
        ;;
    Logout) 
        hyprctl dispatch exit
        ;;
    *)
        exit 1
        ;;
esac
