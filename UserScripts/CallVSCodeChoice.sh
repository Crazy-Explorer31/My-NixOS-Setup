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

code $directory
