# 🚀 Инструкции по настройке TinderMiniApp

## 📊 Текущий статус проекта: 60% готов

### ✅ Что уже готово:
- ✅ Структура проекта корректна
- ✅ Package.json настроен
- ✅ TypeScript файлы в порядке
- ✅ Git репозиторий инициализирован
- ✅ .gitignore настроен правильно

### ❌ Что нужно исправить:

## 1. 🔧 Настройка переменных окружения

### Проблема:
- BOT_TOKEN и BOT_USERNAME содержат тестовые значения
- Нужны реальные токены от Telegram

### Решение:

1. **Создайте Telegram бота:**
   - Найдите @BotFather в Telegram
   - Отправьте команду `/newbot`
   - Придумайте имя бота (например: "My Dating Bot")
   - Придумайте username бота (например: "my_dating_bot")
   - Скопируйте полученный токен

2. **Обновите .env файл:**
   ```bash
   # Замените эти строки в .env файле:
   BOT_TOKEN=ваш_реальный_токен_от_botfather
   BOT_USERNAME=ваш_username_бота_без_@
   VITE_BOT_USERNAME=ваш_username_бота_без_@
   ```

## 2. 📦 Установка зависимостей

### Проблема:
- Отсутствуют важные зависимости в корневом package.json

### Решение:

1. **Установите зависимости для корневого проекта:**
   ```bash
   npm install express cors dotenv
   npm install -D typescript @types/node @types/express ts-node
   ```

2. **Установите зависимости для backend:**
   ```bash
   cd backend
   npm install
   cd ..
   ```

3. **Установите зависимости для frontend:**
   ```bash
   cd tg-web-app
   npm install
   cd ..
   ```

## 3. 🗃️ Настройка базы данных

### Вариант A: MongoDB Atlas (рекомендуется для начала)

1. **Используйте тест Atlas:**
   ```bash
   node TEST/mongo-atlas.test.cjs
   ```

2. **Если хотите свою БД:**
   - Зарегистрируйтесь на [MongoDB Atlas](https://www.mongodb.com/atlas)
   - Создайте кластер
   - Получите строку подключения
   - Обновите MONGO_URI в .env

### Вариант B: Локальный MongoDB

1. **Следуйте инструкциям:**
   ```bash
   # Откройте файл с инструкциями
   notepad TEST/setup-mongodb.md
   ```

## 4. 📝 Коммит изменений

### Проблема:
- 13 измененных файлов и 5 новых файлов не закоммичены

### Решение:

```bash
# Добавить все файлы в Git
git add .

# Создать коммит
git commit -m "Initial setup: added tests, configs, and documentation"

# Проверить статус
git status
```

## 5. 🧪 Проверка готовности

### После выполнения всех шагов:

```bash
# Запустите тест готовности
node TEST/app-components.test.cjs

# Проверьте подключение к MongoDB
node TEST/mongo-simple.test.cjs

# Или используйте Atlas
node TEST/mongo-atlas.test.cjs
```

## 6. 🚀 Запуск приложения

### После настройки:

```bash
# Запуск backend
cd backend
npm run dev

# В новом терминале - запуск frontend
cd tg-web-app
npm run dev
```

## 📋 Чек-лист готовности

- [ ] Получен реальный BOT_TOKEN от @BotFather
- [ ] Обновлен .env файл с реальными значениями
- [ ] Установлены все зависимости (npm install)
- [ ] Настроена база данных (Atlas или локальная)
- [ ] Закоммичены все изменения в Git
- [ ] Тест готовности показывает 100%
- [ ] Приложение запускается без ошибок

## 🆘 Помощь

Если возникли проблемы:

1. **Проверьте логи:**
   ```bash
   node TEST/app-components.test.cjs
   ```

2. **Проверьте MongoDB:**
   ```bash
   node TEST/mongo-simple.test.cjs
   ```

3. **Проверьте переменные окружения:**
   ```bash
   # Убедитесь, что .env содержит реальные значения
   type .env
   ```

---

**Следующий шаг:** После выполнения всех инструкций запустите `node TEST/app-components.test.cjs` для проверки готовности проекта.