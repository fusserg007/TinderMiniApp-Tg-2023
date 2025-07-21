# Настройка тестового сервера Telegram для Mini Apps

## 🚀 Быстрое развертывание (Рекомендуемый способ)

### Вариант 1: Vercel (Frontend) + Railway (Backend)

#### Шаг 1: Подготовка проекта

1. **Создайте GitHub репозиторий** (если еще не создан)
2. **Загрузите код** в репозиторий
3. **Создайте .gitignore** в корне проекта:

```gitignore
# Конфиденциальные данные
.env
.env.local
.env.production
*.session
*.session-journal
Sessions/

# Зависимости
node_modules/

# Сборка
dist/
build/

# Логи
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
```

#### Шаг 2: Развертывание Frontend на Vercel

1. **Перейдите на** [vercel.com](https://vercel.com)
2. **Зарегистрируйтесь** через GitHub
3. **Нажмите "New Project"**
4. **Выберите ваш репозиторий**
5. **Настройте проект:**
   - **Root Directory:** `tg-web-app`
   - **Framework Preset:** Vite
   - **Build Command:** `npm run build`
   - **Output Directory:** `dist`
6. **Нажмите "Deploy"**

**Результат:** Получите URL вида `https://your-app.vercel.app`

#### Шаг 3: Развертывание Backend на Railway

1. **Перейдите на** [railway.app](https://railway.app)
2. **Зарегистрируйтесь** через GitHub
3. **Нажмите "New Project"**
4. **Выберите "Deploy from GitHub repo"**
5. **Выберите ваш репозиторий**
6. **Настройте проект:**
   - **Root Directory:** `backend`
   - **Start Command:** `npm run dev`
7. **Добавьте переменные окружения:**
   ```
   NODE_ENV=production
   PORT=4000
   TELEGRAM_BOT_TOKEN=ваш_токен_бота
   FRONTEND_URL=https://your-app.vercel.app
   ```
8. **Нажмите "Deploy"**

**Результат:** Получите URL вида `https://your-backend.railway.app`

#### Шаг 4: Настройка Telegram Bot

1. **Найдите @BotFather** в Telegram
2. **Отправьте команду:** `/setmenubutton`
3. **Выберите вашего бота**
4. **Введите URL:** `https://your-app.vercel.app`
5. **Установите webhook:**
   ```bash
   curl -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook" \
        -H "Content-Type: application/json" \
        -d '{"url": "https://your-backend.railway.app/webhook"}'
   ```

### Вариант 2: Netlify (Альтернатива Vercel)

#### Frontend на Netlify

1. **Перейдите на** [netlify.com](https://netlify.com)
2. **Зарегистрируйтесь** через GitHub
3. **Нажмите "New site from Git"**
4. **Выберите репозиторий**
5. **Настройте:**
   - **Base directory:** `tg-web-app`
   - **Build command:** `npm run build`
   - **Publish directory:** `tg-web-app/dist`

### Вариант 3: Render (Full-Stack)

1. **Перейдите на** [render.com](https://render.com)
2. **Создайте Web Service** для backend
3. **Создайте Static Site** для frontend

## 🔧 Локальное тестирование с туннелями

### Ngrok (уже настроен в проекте)

```bash
# В корневой папке проекта
npm run public-link
```

### Localtunnel (альтернатива)

```bash
# Установка
npm install -g localtunnel

# Запуск для frontend
lt --port 5173 --subdomain your-app-name

# Запуск для backend
lt --port 4000 --subdomain your-api-name
```

### Cloudflare Tunnel

```bash
# Установка
npm install -g cloudflared

# Запуск
cloudflared tunnel --url http://localhost:5173
```

## 📝 Проверка работы

### 1. Проверка Frontend
- Откройте `https://your-app.vercel.app`
- Убедитесь, что приложение загружается

### 2. Проверка Backend
- Откройте `https://your-backend.railway.app/health`
- Должен вернуть статус "OK"

### 3. Проверка Telegram Integration
- Откройте бота в Telegram
- Нажмите кнопку меню
- Mini App должно открыться

## 🛠️ Устранение проблем

### Проблема: CORS ошибки
**Решение:** Добавьте в backend/run-dev-mode.ts:
```javascript
app.use(cors({
  origin: ['https://your-app.vercel.app', 'https://web.telegram.org'],
  credentials: true
}));
```

### Проблема: Webhook не работает
**Решение:** Проверьте URL webhook:
```bash
curl "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getWebhookInfo"
```

### Проблема: Mini App не открывается
**Решение:** 
1. Проверьте HTTPS (обязательно для Telegram)
2. Убедитесь, что URL доступен публично
3. Проверьте настройки бота в @BotFather

## 📊 Мониторинг

### Vercel
- Логи доступны в панели управления
- Автоматические уведомления о деплое

### Railway
- Встроенные метрики
- Логи в реальном времени
- Автоматическое масштабирование

## 🔒 Безопасность

1. **Никогда не коммитьте:**
   - `.env` файлы
   - Токены ботов
   - API ключи
   - Session файлы

2. **Используйте переменные окружения** для всех секретов

3. **Настройте CORS** правильно

4. **Валидируйте данные** от Telegram

## 📈 Оптимизация

### Frontend
- Минификация кода (автоматически в Vercel)
- CDN (встроено в Vercel)
- Кэширование статических ресурсов

### Backend
- Используйте connection pooling для MongoDB
- Кэшируйте частые запросы
- Настройте rate limiting

## 🎯 Следующие шаги

1. **Протестируйте** все функции Mini App
2. **Настройте мониторинг** ошибок
3. **Добавьте аналитику** (если нужно)
4. **Оптимизируйте производительность**
5. **Подготовьте к продакшену**

---

**Время развертывания:** 10-15 минут  
**Стоимость:** Бесплатно (в рамках лимитов)  
**Сложность:** Низкая  
**Надежность:** Высокая  

**Готово к тестированию!** 🚀