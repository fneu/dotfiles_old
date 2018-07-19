#! /bin/bash

action=$@

if [[ -z "$action" ]]; then
    echo Sperren
    echo Energie sparen
    echo Herunterfahren
    echo Neu starten
    echo Windows starten
else
    if [ "$action" == "Sperren" ]
    then
        killall rofi && lock
    elif [ "$action" == "Energie sparen" ]
    then
        systemctl suspend
    elif [ "$action" == "Herunterfahren" ]
    then
        systemctl poweroff
    elif [ "$action" == "Neu starten" ]
    then
        systemctl reboot
    elif [ "$action" == "Windows starten" ]
    then
        sudo grub2-reboot 2 && systemctl reboot
    fi
fi
