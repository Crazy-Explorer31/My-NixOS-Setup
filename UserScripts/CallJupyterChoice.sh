#!/bin/sh

directory="$(zenity --file-selection --directory)"

if [ -z "$directory" ]; then
    echo "Директория не выбрана. Операция отменена."
    exit 1
fi

if [ ! -d "$directory" ]; then
    echo "Выбранная директория не существует: $directory"
    exit 1
fi

if [ -z "$directory" ] || [ "$directory" = "" ]; then
    echo "Пустая строка директории"
    exit 1
fi

cd /home/stepan/ml_nix_env/
nix-shell --run "jupyter-lab $directory"
# jupyter-lab $directory
