#!/bin/bash

# Скрипт для генерации rofi .rasi темы из JSON настроек
# Использование: ./generate-rofi-theme.sh [путь_к_json] [выходной_файл]

# Параметры по умолчанию
CONFIG_FILE="${1:-$HOME/.config/noctalia/colors.json}"
OUTPUT_FILE="${2:-$HOME/my-NixOS/UserConfigs/RofiConfig.rasi}"
TEMPLATE_FILE="${3:-}"

# Проверка наличия файла конфигурации
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Ошибка: Файл конфигурации не найден: $CONFIG_FILE"
    echo "Использую цвета по умолчанию..."
    
    # Цвета по умолчанию
    declare -A colors=(
        ["BG"]="#141311"
        ["BGA"]="#d1c6a2"
        ["FG"]="#e6e2dd"
        ["FGA"]="#becbb0"
        ["BDR"]="#4a473d"
        ["SEL"]="#373017"
        ["UGT"]="#ffb4ab"
        ["IMG"]="#cdc6b5"
        ["OFF"]="#211f1d"
        ["ON"]="#becbb0"
    )
else
    echo "Чтение конфигурации из: $CONFIG_FILE"
    
    # Извлечение цветов из JSON
    declare -A colors=(
        ["BG"]=$(jq -r '.mSurface // "#141311"' "$CONFIG_FILE")
        ["BGA"]=$(jq -r '.mPrimary // "#d1c6a2"' "$CONFIG_FILE")
        ["FG"]=$(jq -r '.mOnSurface // "#e6e2dd"' "$CONFIG_FILE")
        ["FGA"]=$(jq -r '.mHover // .mTertiary // "#becbb0"' "$CONFIG_FILE")
        ["BDR"]=$(jq -r '.mOutline // "#4a473d"' "$CONFIG_FILE")
        ["SEL"]=$(jq -r '.mOnPrimary // "#373017"' "$CONFIG_FILE")
        ["UGT"]=$(jq -r '.mError // "#ffb4ab"' "$CONFIG_FILE")
        ["IMG"]=$(jq -r '.mSecondary // "#cdc6b5"' "$CONFIG_FILE")
        ["OFF"]=$(jq -r '.mSurfaceVariant // "#211f1d"' "$CONFIG_FILE")
        ["ON"]=$(jq -r '.mHover // .mTertiary // "#becbb0"' "$CONFIG_FILE")
    )
fi

# Функция для добавления альфа-канала
add_alpha() {
    local color="$1"
    local alpha="${2:-ff}"
    
    # Если цвет уже имеет альфа-канал, возвращаем как есть
    if [[ ${#color} -eq 9 ]]; then
        echo "$color"
    elif [[ ${#color} -eq 7 ]]; then
        echo "${color}${alpha}"
    else
        echo "$color"
    fi
}

# Добавляем альфа-каналы к цветам
for key in "${!colors[@]}"; do
    colors["$key"]=$(add_alpha "${colors[$key]}")
done

# Проверяем наличие шаблона
if [ -n "$TEMPLATE_FILE" ] && [ -f "$TEMPLATE_FILE" ]; then
    echo "Использую шаблон из: $TEMPLATE_FILE"
    TEMPLATE_CONTENT=$(cat "$TEMPLATE_FILE")
else
    # Шаблон по умолчанию (ваш текущий .rasi файл)
    TEMPLATE_CONTENT='configuration {
    show-icons:                     true;
    display-drun:                   "";
    drun-display-format:            "{icon} {name}";
    disable-history:                false;
    click-to-exit:                  true;
    location:                       0;
}

/*****----- Global Properties -----*****/
* {
    font: "Iosevka 12";
    
    BG:    @BG_COLOR;
    BGA:   @BGA_COLOR;
    FG:    @FG_COLOR;
    FGA:   @FGA_COLOR;
    BDR:   @BDR_COLOR;
    SEL:   @SEL_COLOR;
    UGT:   @UGT_COLOR;
    IMG:   @IMG_COLOR;
    OFF:   @OFF_COLOR;
    ON:    @ON_COLOR;
}

window {
    transparency:                   "real";
    background-color:               @BG;
    text-color:                     @FG;
    border:                         2px;
    border-color:                   @BDR;
    border-radius:                  10px;
    width:                          35%;
    anchor:                         center;
    x-offset:                       0;
    y-offset:                       0;
}

prompt {
    enabled:                        true;
    padding:                        8px;
    background-color:               @BG;
    text-color:                     @IMG;
}

textbox-prompt-colon {
    expand:                         false;
    str:                            "";
    border-radius:                  100%;
    background-color:               @SEL;
    text-color:                     @FG;
    padding:                        8px 12px 8px 12px;
    font:                           "Iosevka Nerd Font 10";
}

entry {
    background-color:               @BG;
    text-color:                     @FG;
    placeholder-color:              @FG;
    expand:                         true;
    horizontal-align:               0;
    placeholder:                    "";
    blink:                          true;
    border:                         0px 0px 2px 0px;
    border-color:                   @BDR;
    border-radius:                  10px;
    padding:                        8px;
}

inputbar {
    children:                       [ textbox-prompt-colon, entry ];
    background-color:               @BG;
    text-color:                     @FG;
    expand:                         false;
    border:                         0px 0px 0px 0px;
    border-radius:                  0px;
    border-color:                   @BDR;
    margin:                         0px 0px 0px 0px;
    padding:                        0px;
    position:                       center;
}

case-indicator {
    background-color:               @BG;
    text-color:                     @FG;
    spacing:                        0;
}

listview {
    background-color:               @BG;
    columns:                        1;
    lines:                          7;
    spacing:                        4px;
    cycle:                          false;
    dynamic:                        true;
    layout:                         vertical;
}

/* ---- Scrollbar ---- */
scrollbar {
    border:                         0px;
    border-radius:                  10px;
    background-color:               transparent;
    handle-color:                   @BDR;
    handle-width:                   2px ;
    padding:                        0;
}

mainbox {
    background-color:               @BG;
    children:                       [ inputbar, message, listview ];
    spacing:                        15px;
    padding:                        15px;
}

element {
    background-color:               @BG;
    text-color:                     @FG;
    orientation:                    horizontal;
    border-radius:                  4px;
    padding:                        12px;
}

element-icon {
    background-color:               inherit;
    text-color:                     inherit;
    horizontal-align:               0.5;
    vertical-align:                 0.5;
    size:                           24px;
    border:                         0px;
}

element-text {
    background-color:               inherit;
    text-color:                     inherit;
    expand:                         true;
    horizontal-align:               0;
    vertical-align:                 0.5;
    margin:                         2px 0px 2px 2px;
}

element normal.urgent,
element alternate.urgent {
    background-color:               @UGT;
    text-color:                     @FG;
    border-radius:                  9px;
}

element normal.active,
element alternate.active {
    background-color:               @BGA;
    text-color:                     @FG;
}

element-text selected,
element selected {
    background-color:               @BGA;
    text-color:                     @SEL;
    border:                         0px 0px 0px 0px;
    border-radius:                  10px;
    border-color:                   @BDR;
}

element selected.urgent {
    background-color:               @UGT;
    text-color:                     @FG;
}

element selected.active {
    background-color:               @BGA;
    color:                          @FG;
}

/*****----- Message -----*****/
message {
    background-color:               transparent;
    border:                         0px;
}

error-message {
    padding:                        20px;
}

textbox {
    padding:                        10px;
    border-radius:                  10px;
    background-color:               @BDR;
    text-color:                     @SEL;
    vertical-align:                 0.5;
    horizontal-align:               0.5;
}'
fi

# Заменяем плейсхолдеры на реальные цвета
output_content="$TEMPLATE_CONTENT"

for key in "${!colors[@]}"; do
    placeholder="@${key}_COLOR"
    value="${colors[$key]}"
    output_content="${output_content//$placeholder/$value}"
done

# Заменяем специфичные плейсхолдеры
output_content="${output_content//\@BG_COLOR/${colors[BG]}}"
output_content="${output_content//\@BGA_COLOR/${colors[BGA]}}"
output_content="${output_content//\@FG_COLOR/${colors[FG]}}"
output_content="${output_content//\@FGA_COLOR/${colors[FGA]}}"
output_content="${output_content//\@BDR_COLOR/${colors[BDR]}}"
output_content="${output_content//\@SEL_COLOR/${colors[SEL]}}"
output_content="${output_content//\@UGT_COLOR/${colors[UGT]}}"
output_content="${output_content//\@IMG_COLOR/${colors[IMG]}}"
output_content="${output_content//\@OFF_COLOR/${colors[OFF]}}"
output_content="${output_content//\@ON_COLOR/${colors[ON]}}"

# Заменяем переменные даты и файла
output_content="${output_content//\$(date)/$(date)}"
output_content="${output_content//\$(basename \"\$CONFIG_FILE\")/$(basename "$CONFIG_FILE")}"

# Создаем директорию, если её нет
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Сохраняем сгенерированный файл
echo "$output_content" > "$OUTPUT_FILE"

echo "Тема успешно сгенерирована: $OUTPUT_FILE"
echo "Использованные цвета:"
for key in "${!colors[@]}"; do
    printf "  %-4s = %s\n" "$key" "${colors[$key]}"
done

# Делаем скрипт исполняемым (если он сам себя)
chmod +x "$0"

echo "Для использования с rofi: rofi -show drun -theme $OUTPUT_FILE"
