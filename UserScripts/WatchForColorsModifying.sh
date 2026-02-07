#!/bin/sh

while true
do
    inotifywait -e modify /home/stepan/.config/noctalia/colors.json && /home/stepan/my-NixOS/UserScripts/GenerateRofiConfig.sh
done
