#!/bin/bash

# Папка для проверки изменений
DIR=/home/stepan/my-nixos/

# Проверяем, были ли изменены файлы в папке менее чем минуту назад
if find "$DIR" -type f -mmin -1 | grep -q .; then
    # Если есть изменения, спрашиваем пользователя
    read -p "Do you want to rebuild system now? (y/n): " answer
    if [[ "$answer" == "y" ]]; then
        # Запускаем команду для сборки системы
	echo "Rebuilding..."
        sudo nixos-rebuild switch --flake "$DIR"
	echo "Rebuilded successfully!"
    else
        echo "Exiting without rebuilding"
    fi
else
    # Если изменений нет, выводим сообщение
    echo "No changes"
fi
read -p "Press Enter to exit..."
