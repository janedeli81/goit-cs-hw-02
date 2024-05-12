#!/bin/bash

# Визначаємо масив з URL вебсайтів для перевірки
SITES=("https://google.com" "https://facebook.com" "https://twitter.com")

# Назва файлу для запису результатів
LOG_FILE="website_status.log"

# Очищаємо файл логів перед записом нових результатів
> $LOG_FILE

# Перебираємо кожен сайт зі списку
for SITE in "${SITES[@]}"; do
    echo "Перевіряємо $SITE..."

    # Використовуємо curl з аргументом -L для вірної обробки переадресації
    STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}\n" -L "$SITE")

    # Перевіряємо, чи статус-код дорівнює 200
    if [ "$STATUS_CODE" -eq 200 ]; then
        echo "[${SITE}] is UP" | tee -a $LOG_FILE
    else
        echo "[${SITE}] is DOWN" | tee -a $LOG_FILE
    fi
done

echo "Результати перевірки записано у файл $LOG_FILE"
