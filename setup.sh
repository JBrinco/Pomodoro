#!/bin/bash
#Simple pomodoro timer for Linux SETUP
#Run this for installation
#THIS FILE IS NOT WORKING! DONT USE IT!

NAME=$(whoami)

mkdir /home/$NAME/.config/pomodoro
cp notification.ogg /home/$NAME/.config/pomodoro/notification

# TO ADD: check for existing /usr/local/bin/pomodoro
if [[ $(echo $PATH | grep /usr/local/bin) ]]; then
  sudo cp pomodoro.sh /usr/bin/pomodoro
else
    echo "/usr/local/bin not in the PATH variable"
fi
