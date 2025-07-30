# 🔧 ПОДРОБНОЕ РУКОВОДСТВО ПО ПЕРЕМЕННЫМ ОКРУЖЕНИЯ

## 📋 ОБЗОР ПЕРЕМЕННЫХ

Приложение использует множество переменных окружения для настройки различных сервисов. Все переменные должны быть добавлены в панель управления Timeweb Cloud.

---

## 🗄️ MONGODB - БАЗА ДАННЫХ

### MONGODB_URI
**Описание**: Строка подключения к MongoDB Atlas  
**Формат**: `mongodb+srv://username:password@cluster.xxxxx.mongodb.net/?retryWrites=true&w=majority&appName=ClusterName`  
**Пример**: `mongodb+srv://dating_user:MyPassword123@cluster0.abc123.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0`

**Как получить**:
1. Зайдите в MongoDB Atlas
2. Выберите ваш кластер
3. Нажмите "Connect" → "Connect your application"
4. Скопируйте строку и замените `<password>` на реальный пароль

**Важные моменты**:
- Пароль должен быть URL-encoded (специальные символы заменены на коды)
- Пользователь должен иметь права "Atlas admin"
- IP 0.0.0.0/0 должен быть разрешен в Network Access

### MONGODB_DATABASE
**Описание**: Название базы данных  
**Значение**: `dating_app`  
**Примечание**: База данных создается автоматически при первом подключении

---

## 📦 MINIO - ХРАНИЛИЩЕ ФАЙЛОВ

MinIO используется как S3-совместимое хранилище для фотографий пользователей.

### MINIO_ROOT_USER
**Описание**: Администратор MinIO  
**Рекомендуемое значение**: `minio_admin`  
**Примечание**: Можете изменить на свое значение

### MINIO_ROOT_PASSWORD
**Описание**: Пароль администратора MinIO  
**Рекомендуемое значение**: `minio_super_secret_password_2024`  
**Требования**: Минимум 8 символов, используйте сложный пароль

### AWS_ACCESS_KEY_ID
**Описание**: Access Key для S3 API  
**Значение**: Должно совпадать с `MINIO_ROOT_USER`  
**Пример**: `minio_admin`

### AWS_SECRET_ACCESS_KEY
**Описание**: Secret Key для S3 API  
**Значение**: Должно совпадать с `MINIO_ROOT_PASSWORD`  
**Пример**: `minio_super_secret_password_2024`

### AWS_BUCKET
**Описание**: Название S3 bucket для хранения файлов  
**Рекомендуемое значение**: `dating-app-files`  
**Примечание**: Bucket создается автоматически при запуске

### AWS_REGION
**Описание**: Регион S3 (для совместимости)  
**Значение**: `us-east-1`  
**Примечание**: Для MinIO значение не критично, но должно быть указано

---

## 🖼️ IMGPROXY - ОБРАБОТКА ИЗОБРАЖЕНИЙ

ImgProxy используется для ресайза, сжатия и оптимизации изображений.

### IMGPROXY_KEY
**Описание**: Ключ для подписи URL ImgProxy  
**Формат**: 64 символа (hex)  
**Пример**: `943b421c9eb07c830af81030552c86009268de4e532ba2ee2eab8247c6da0881`

**Как сгенерировать новый**:
```bash
# Linux/Mac
openssl rand -hex 32

# Windows PowerShell
[System.Web.Security.Membership]::GeneratePassword(64, 0)

# Онлайн
# Используйте generate-timeweb-env.bat или generate-timeweb-env.sh
```

### IMGPROXY_SALT
**Описание**: Соль для подписи URL ImgProxy  
**Формат**: 64 символа (hex)  
**Пример**: `520f986b998545b4785e0defbc4f3c1203f22de2374a3d53cb7a7fe9fea309c5`

**Примечание**: Должна отличаться от IMGPROXY_KEY

---

## 🤖 TELEGRAM BOT

### BOT_TOKEN
**Описание**: Токен Telegram бота от @BotFather  
**Формат**: `XXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX`  
**Пример**: `1234567890:ABCdefGHIjklMNOpqrsTUVwxyz123456789`

**Как получить**:
1. Найдите @BotFather в Telegram
2. Отправьте `/newbot`
3. Следуйте инструкциям
4. Сохраните полученный токен

**Важно**: Никогда не публикуйте токен в открытом доступе!

### BOT_USERNAME
**Описание**: Username бота (без символа @)  
**Формат**: `bot_name_bot`  
**Пример**: `my_dating_app_bot`

**Примечание**: Должен заканчиваться на `_bot` и совпадать с username, указанным при создании бота

---

## 🌐 PRODUCTION URLs

### VITE_BACKEND_URL
**Описание**: URL API для frontend приложения  
**Формат**: `https://домен/api`  
**Пример**: `https://my-dating-app.twc1.net/api`

**Важные моменты**:
- ОБЯЗАТЕЛЬНО используйте HTTPS
- НЕ добавляйте слеш в конце
- Домен должен совпадать с доменом приложения в Timeweb
- Путь всегда `/api`

### DOMAIN
**Описание**: Основной домен приложения  
**Формат**: `домен.twc1.net` или ваш собственный домен  
**Пример**: `my-dating-app.twc1.net`

**Примечание**: Используется для внутренних настроек и CORS

---

## ⚙️ СИСТЕМНЫЕ ПЕРЕМЕННЫЕ

### NODE_ENV
**Описание**: Режим работы Node.js приложения  
**Значение**: `production`  
**Примечание**: НЕ изменяйте для продакшена

### PORT
**Описание**: Порт для backend сервиса  
**Значение**: `4000`  
**Примечание**: Используется внутри Docker контейнера

---

## 📝 ШАБЛОН ПЕРЕМЕННЫХ ДЛЯ TIMEWEB

Скопируйте и вставьте в панель управления Timeweb Cloud:

```env
# MongoDB Atlas
MONGODB_URI=mongodb+srv://ВАШ_ПОЛЬЗОВАТЕЛЬ:ВАШ_ПАРОЛЬ@ВАШ_КЛАСТЕР.xxxxx.mongodb.net/?retryWrites=true&w=majority&appName=ВАШ_КЛАСТЕР
MONGODB_DATABASE=dating_app

# MinIO Storage
MINIO_ROOT_USER=minio_admin
MINIO_ROOT_PASSWORD=minio_super_secret_password_2024
AWS_ACCESS_KEY_ID=minio_admin
AWS_SECRET_ACCESS_KEY=minio_super_secret_password_2024
AWS_BUCKET=dating-app-files
AWS_REGION=us-east-1

# ImgProxy
IMGPROXY_KEY=943b421c9eb07c830af81030552c86009268de4e532ba2ee2eab8247c6da0881
IMGPROXY_SALT=520f986b998545b4785e0defbc4f3c1203f22de2374a3d53cb7a7fe9fea309c5

# Telegram Bot
BOT_TOKEN=ВАШ_ТОКЕН_ОТ_BOTFATHER
BOT_USERNAME=ваш_бот_username

# Production URLs
VITE_BACKEND_URL=https://ваше-приложение.twc1.net/api
DOMAIN=ваше-приложение.twc1.net

# System
NODE_ENV=production
PORT=4000
```

---

## 🔒 БЕЗОПАСНОСТЬ ПЕРЕМЕННЫХ

### Критически важные переменные:
- `BOT_TOKEN` - доступ к Telegram боту
- `MONGODB_URI` - доступ к базе данных
- `MINIO_ROOT_PASSWORD` - доступ к файлам
- `IMGPROXY_KEY` и `IMGPROXY_SALT` - безопасность изображений

### Рекомендации по безопасности:
1. **Никогда не публикуйте** переменные в GitHub
2. **Используйте сложные пароли** для MinIO
3. **Регулярно обновляйте** токены и ключи
4. **Ограничьте доступ** к панели управления Timeweb
5. **Используйте разные значения** для разработки и продакшена

---

## 🔄 ОБНОВЛЕНИЕ ПЕРЕМЕННЫХ

### В процессе разработки:
1. Обновите переменную в панели Timeweb
2. Перезапустите приложение
3. Проверьте логи на ошибки

### При смене домена:
1. Обновите `VITE_BACKEND_URL` и `DOMAIN`
2. Перезапустите приложение
3. Обновите URL в @BotFather

### При смене MongoDB:
1. Обновите `MONGODB_URI`
2. Убедитесь, что новая БД доступна
3. Перезапустите приложение
4. Проверьте подключение в логах

---

## 🧪 ТЕСТИРОВАНИЕ ПЕРЕМЕННЫХ

### Проверка MongoDB:
```bash
# Используйте MongoDB Compass или mongosh
# Подключитесь с помощью MONGODB_URI
```

### Проверка Telegram Bot:
```bash
curl "https://api.telegram.org/bot<BOT_TOKEN>/getMe"
```

### Проверка API:
```bash
curl "https://<DOMAIN>/api/health"
```

### Проверка MinIO:
```bash
# Проверьте логи object-storage сервиса в Timeweb
# Должны быть сообщения о создании bucket'а
```

---

## ❗ ЧАСТЫЕ ОШИБКИ

### 1. Неправильная MONGODB_URI
```
Ошибка: MongoNetworkError: connection timed out
Решение: Проверьте пароль и Network Access в MongoDB Atlas
```

### 2. Неправильный BOT_TOKEN
```
Ошибка: 401 Unauthorized
Решение: Получите новый токен у @BotFather
```

### 3. Неправильный VITE_BACKEND_URL
```
Ошибка: CORS или 404 на API запросы
Решение: Убедитесь, что URL точно соответствует домену
```

### 4. Несовпадение MinIO переменных
```
Ошибка: Access Denied при загрузке файлов
Решение: AWS_ACCESS_KEY_ID должен равняться MINIO_ROOT_USER
```

---

**💡 Совет**: Всегда проверяйте логи после изменения переменных окружения!