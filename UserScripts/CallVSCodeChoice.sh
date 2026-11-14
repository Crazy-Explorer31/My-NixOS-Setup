#!/bin/sh

directory="$(zenity --file-selection --directory)"

# 1. Проверка на отмену выбора
if [ -z "$directory" ]; then
    echo "Директория не выбрана. Операция отменена."
    exit 1
fi

# 2. Проверка на существование директории
if [ ! -d "$directory" ]; then
    echo "Выбранная директория не существует: $directory"
    exit 1
fi

# 3. Проверка наличия flake.nix в выбранной директории
if [ -f "$directory/flake.nix" ]; then
    echo "Найден flake.nix. Запуск nix develop..."
    cd "$directory" && alacritty -e ~/my-NixOS/UserScripts/RunNixDevelop.sh
    exit 0
fi

# 4. Если flake.nix нет, просто открываем директорию в VS Code
code "$directory"
