#!/bin/bash

STATUS_FILE="/tmp/gpu-recorder-portal.status"
OUTPUT_DIR="$HOME/Videos"
mkdir -p "$OUTPUT_DIR"

# Читаем текущее состояние (если файла нет, считаем что "0" — остановлено)
STATE=$(cat "$STATUS_FILE" 2>/dev/null || echo "0")

if [ "$STATE" = "1" ]; then
    # останавливаем запись и сбрасываем статус
    killall -SIGINT gpu-screen-recorder
    echo "0" > "$STATUS_FILE"
    notify-send -t 3000 "GPU Screen Recorder" "Запись остановлена и сохранена"
else
    # записываем статус "1" и запускаем запись
    echo "1" > "$STATUS_FILE"
    FILE="$OUTPUT_DIR/Recordings/recording_$(date +%Y%m%d_%H%M%S).mp4"
    gpu-screen-recorder -w portal -f 60 -a default_output -o "$FILE" &
fi
