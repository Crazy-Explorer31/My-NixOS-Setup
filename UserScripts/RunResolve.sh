#!/bin/sh
mkdir -p ~/.local/share/DaVinciResolve/logs

# Запускаем Xephyr с оптимизациями
Xephyr :1 -screen 1920x1080x24 -ac -resizeable -host-cursor &
XEPHYR_PID=$!
sleep 2

# Переменные для Resolve
export DISPLAY=:1
export QT_QPA_PLATFORM=xcb
export __NV_PRIME_RENDER_OFFLOAD=1
export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __VK_LAYER_NV_optimus=NVIDIA_only
export DRI_PRIME=1

# Запускаем Resolve
~/.local/bin/davinci-resolve-xcb "$@"

# После закрытия Resolve убиваем Xephyr
kill $XEPHYR_PID 2>/dev/null
