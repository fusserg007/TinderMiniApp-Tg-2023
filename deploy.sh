#!/bin/bash

# Скрипт для быстрого развертывания на TimeWeb Cloud

echo "🚀 Подготовка к развертыванию на TimeWeb Cloud..."

# Проверяем наличие необходимых файлов
if [ ! -f "docker-compose.timeweb.yml" ]; then
    echo "❌ Файл docker-compose.timeweb.yml не найден!"
    exit 1
fi

if [ ! -f ".env.timeweb" ]; then
    echo "❌ Файл .env.timeweb не найден!"
    exit 1
fi

echo "✅ Все необходимые файлы найдены"

# Копируем переменные окружения
cp .env.timeweb .env

echo "✅ Переменные окружения настроены"

# Запускаем развертывание
echo "🔄 Запуск развертывания..."
docker-compose -f docker-compose.timeweb.yml up -d

echo "✅ Развертывание завершено!"
echo ""
echo "📋 Следующие шаги:"
echo "1. Проверьте логи: docker-compose -f docker-compose.timeweb.yml logs -f"
echo "2. Откройте ваш домен в браузере"
echo "3. Настройте webhook бота"
echo ""
echo "📖 Подробная инструкция в файле DEPLOY_GUIDE.md"