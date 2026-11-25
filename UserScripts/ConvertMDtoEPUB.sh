#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Использование: md2epub <файл.md>"
    exit 1
fi

INPUT="$1"
if [ ! -f "$INPUT" ]; then
    echo "Ошибка: файл '$INPUT' не найден."
    exit 1
fi

OUTPUT="${INPUT%.*}.epub"
if [ "$INPUT" = "$OUTPUT" ]; then
    OUTPUT="${INPUT}.epub"
fi

CSS_PATH="$HOME/my-NixOS/UserConfigs/pocketbook.css"

# Берем имя файла без пути и расширения в качестве названия книги
TITLE=$(basename "${INPUT%.*}")

pandoc "$INPUT" \
    -o "$OUTPUT" \
    --css="$CSS_PATH" \
    --highlight-style=monochrome \
    --metadata title="$TITLE" \
    --toc \
    -f markdown+hard_line_breaks-startnum

echo "Готово: $OUTPUT"
