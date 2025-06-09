# Финальная настройка проекта TinderMiniApp

## Текущий статус проекта

✅ **Готово (60%):**
- Структура проекта
- Package.json и зависимости
- TypeScript файлы
- Git репозиторий

❌ **Требует настройки (40%):**
- Конфигурация Telegram бота
- База данных MongoDB

## Шаги для завершения настройки

### 1. Настройка Telegram бота (обязательно)

📖 **Подробная инструкция:** `TEST/telegram-bot-setup.md`

**Быстрые шаги:**
1. Откройте @BotFather в Telegram
2. Создайте нового бота командой `/newbot`
3. Получите токен и username бота
4. Обновите файл `.env`:

```env
BOT_TOKEN=ваш_реальный_токен_от_botfather
BOT_USERNAME=ваш_бот_username
TELEGRAM_BOT_API=ваш_реальный_токен_от_botfather
VITE_BOT_USERNAME=ваш_бот_username
```

### 2. Настройка базы данных (выберите один вариант)

#### Вариант A: MongoDB Atlas (рекомендуется для начала)

📖 **Подробная инструкция:** `TEST/setup-mongodb.md`

**Быстрые шаги:**
1. Зарегистрируйтесь на [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Создайте бесплатный кластер
3. Получите строку подключения
4. Обновите `.env`:

```env
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/dating_app
```

#### Вариант B: Локальный MongoDB через Docker

📖 **Подробная инструкция:** `TEST/docker-setup.md`

**Быстрые шаги:**
1. Установите Docker Desktop
2. Запустите контейнеры:

```powershell
docker-compose -f docker-compose.test.yml up -d
```

### 3. Проверка настройки

После выполнения шагов 1 и 2 запустите финальный тест:

```powershell
node TEST/app-components.test.cjs
```

**Ожидаемый результат:** Готовность проекта 100% ✅

### 4. Запуск приложения

После успешной настройки запустите приложение:

```powershell
# Запуск бэкенда
cd backend
npm run dev

# В новом терминале - запуск фронтенда
cd tg-web-app
npm run dev
```

## Структура файлов настройки

```
TEST/
├── app-components.test.cjs     # Основной тест готовности
├── telegram-bot-setup.md       # Настройка Telegram бота
├── setup-mongodb.md           # Настройка MongoDB Atlas
├── docker-setup.md            # Настройка Docker и локального MongoDB
├── mongo.test.cjs             # Тест подключения к MongoDB
├── mongo-atlas.test.cjs       # Тест MongoDB Atlas
└── final-setup-guide.md       # Этот файл
```

## Полезные команды

```powershell
# Проверка готовности проекта
node TEST/app-components.test.cjs

# Тест подключения к MongoDB
node TEST/mongo.test.cjs

# Тест MongoDB Atlas
node TEST/mongo-atlas.test.cjs

# Запуск Docker контейнеров
docker-compose -f docker-compose.test.yml up -d

# Остановка Docker контейнеров
docker-compose -f docker-compose.test.yml down
```

## Поддержка

Если у вас возникли проблемы:

1. Проверьте все файлы в папке `TEST/`
2. Убедитесь, что все переменные в `.env` заполнены корректно
3. Проверьте, что Docker Desktop запущен (для локального MongoDB)
4. Запустите тесты для диагностики проблем

---

**Следующий шаг:** Настройте Telegram бота согласно `TEST/telegram-bot-setup.md`