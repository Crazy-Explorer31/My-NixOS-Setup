#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Использование: md2pb <файл.md>"
  exit 1
fi

INPUT="$1"

if [ ! -f "$INPUT" ]; then
  echo "Ошибка: файл '$INPUT' не найден."
  exit 1
fi

# Заменяем расширение .md на .pdf (если расширения нет, просто добавляем .pdf)
OUTPUT="${INPUT%.*}.pdf"
if [ "$INPUT" = "$OUTPUT" ]; then
  OUTPUT="${INPUT}.pdf"
fi

CSS_PATH="$HOME/my-NixOS/UserConfigs/pocketbook.css"

pandoc "$INPUT" \
  -o "$OUTPUT" \
  --pdf-engine=weasyprint \
  --css="$CSS_PATH" \
  --highlight-style=monochrome \
  -f markdown+hard_line_breaks-startnum

echo "Готово: $OUTPUT"
