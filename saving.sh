#!/bin/bash

# Папка для проверки изменений
DIR=/home/stepan/my-NixOS/
cd "$DIR"

# Проверяем, есть ли незакоммиченные изменения в настройке системы
if ! [ -z "$(git status --porcelain)" ]; then
    # Если есть изменения, спрашиваем пользователя о необходимости пересборки системы
    read -p "Do you want to rebuild system now? (y/n): " answer
    if [[ "$answer" == "y" ]]; then

	# По необходимости обновляем flake.lock с зависимостями
	nix flake lock --commit-lock-file

	# Коммитим конфиги
	git add .
	read -p "Print new commit message (or nothing to do --amend): " commit_message
	if [ -z "$commit_message" ]; then
	    git commit --amend
	else
	    git commit -m "$commit_message"
	fi

        # Пересбираем систему
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
