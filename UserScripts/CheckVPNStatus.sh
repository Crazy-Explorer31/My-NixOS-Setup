#!/bin/bash

STATE_FILE="/tmp/v2raya_daemon.state"
PID_FILE="/tmp/v2raya_daemon.pid"

if [ ! -f "$STATE_FILE" ]; then
    echo " VPN: нет данных"
    exit 0
fi

state=$(cat "$STATE_FILE")
if [ "$state" = "on" ]; then
    echo " VPN: ВКЛ"
else
    echo " VPN: ВЫКЛ"
fi
