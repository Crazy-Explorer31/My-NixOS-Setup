#!/bin/bash

set -e  # Выход при любой ошибке

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

# Проверяем, существует ли исходная директория
if [ ! -d "$directory" ]; then
    echo "Ошибка: Директория '$directory' не найдена."
    exit 1
fi

# Формируем путь к папке для транскодированных файлов
transcoded_dir="$directory/transcoded"

# Создаем папку transcoded, если её еще нет (-p предотвращает ошибки, если папка уже есть)
mkdir -p "$transcoded_dir"

# Включаем nullglob: если файлов по маске нет, цикл просто не запустится (а не будет обрабатывать строку "*.*")
shopt -s nullglob

# Проходим по всем файлам с расширением в указанной директории
for video_file in "$directory"/*.*; do
    
    # Пропускаем элемент, если это директория (на случай, если есть папки с точкой в имени)
    [ -f "$video_file" ] || continue

    # Получаем чистое имя файла без пути
    filename=$(basename "$video_file")
    
    # Получаем имя файла без расширения
    name_without_ext="${filename%.*}"

    # Формируем полный путь к целевому файлу
    target_file="$transcoded_dir/${name_without_ext}.mov"

    # Проверяем, существует ли уже пара в папке transcoded
    if [ ! -f "$target_file" ]; then
        echo "Транскодирование: $filename -> ${name_without_ext}.mov"
        
        # Выполняем ffmpeg. Все пути в кавычках для поддержки пробелов.
        ffmpeg -i "$video_file" -vf "scale=in_range=full:out_range=limited,format=yuv422p" -c:v dnxhd -profile:v dnxhr_hq -color_range tv -color_primaries bt709 -color_trc bt709 -colorspace bt709 -c:a pcm_s16le -movflags +faststart "$target_file" -y
    else
        echo "Пропуск (уже существует): $filename"
    fi
    
done

# Возвращаем настройку nullglob в исходное состояние
shopt -u nullglob

echo "Обработка завершена!"
