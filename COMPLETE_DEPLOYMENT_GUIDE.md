# 🚀 ПОЛНОЕ РУКОВОДСТВО ПО РАЗВЕРТЫВАНИЮ ПРИЛОЖЕНИЯ ПОД ДОМЕННЫМ ИМЕНЕМ

## 📋 ОБЗОР ПРОЕКТА

Это Telegram Mini App для знакомств (аналог Tinder) с полной микросервисной архитектурой:

### Компоненты системы:
- **Frontend**: React + TypeScript + Vite (папка `tg-web-app/`)
- **Backend**: Node.js + Express + TypeScript (папка `backend/`)
- **База данных**: MongoDB (локальная или MongoDB Atlas)
- **Хранилище файлов**: MinIO S3-совместимое хранилище
- **Обработка изображений**: ImgProxy для ресайза и оптимизации
- **Веб-сервер**: Nginx для проксирования и балансировки
- **Лендинг**: Express сервер для главной страницы (файлы `server.js`, `index.html`)

### Архитектура развертывания:
```
Internet → Nginx (порт 8080) → {
  / → Landing Page (порт 3000)
  /api/ → Backend API (порт 4000)
  /app → Frontend SPA (порт 5173)
  /imgproxy/ → Image Processing (порт 8080)
}
```

---

## 🎯 ЭТАП 1: ПОДГОТОВКА TELEGRAM BOT (10 минут)

### 1.1. Создание Telegram Bot

1. **Откройте Telegram** и найдите **@BotFather**
2. **Отправьте команду** `/start`
3. **Создайте нового бота**:
   ```
   /newbot
   ```
4. **Введите имя бота** (отображаемое имя):
   ```
   My Dating App
   ```
5. **Введите username бота** (должен заканчиваться на _bot):
   ```
   my_dating_app_bot
   ```
6. **СОХРАНИТЕ ТОКЕН БОТА** - он выглядит примерно так:
   ```
   1234567890:ABCdefGHIjklMNOpqrsTUVwxyz
   ```

### 1.2. Создание Web App для бота

1. **Отправьте команду**:
   ```
   /newapp
   ```
2. **Выберите вашего бота** из списка
3. **Введите название приложения**:
   ```
   Dating App
   ```
4. **Введите описание**:
   ```
   Find your soulmate at first sight!
   ```
5. **Загрузите фото** (512x512 пикселей) - можете использовать любое изображение сердца или логотип
6. **Введите ВРЕМЕННЫЙ URL** (позже обновим):
   ```
   https://example.com
   ```
7. **СОХРАНИТЕ короткое имя** Web App (например: `dating`)

### 1.3. Настройка команд бота (опционально)

```
/setcommands
```
Выберите вашего бота и добавьте команды:
```
start - Запустить приложение
help - Помощь
app - Открыть приложение знакомств
```

---

## 🗄️ ЭТАП 2: НАСТРОЙКА MONGODB ATLAS (15 минут)

### 2.1. Создание аккаунта и кластера

1. **Перейдите на** [mongodb.com/atlas](https://www.mongodb.com/atlas)
2. **Нажмите "Try Free"** и создайте аккаунт
3. **Выберите "Build a Database"**
4. **Выберите FREE план** (M0 Sandbox)
5. **Настройки кластера**:
   - **Cloud Provider**: AWS
   - **Region**: выберите ближайший к России (например, Frankfurt eu-central-1)
   - **Cluster Name**: `dating-app-cluster`
6. **Нажмите "Create Cluster"**

### 2.2. Настройка безопасности

#### Создание пользователя базы данных:
1. **Перейдите в "Database Access"** (левое меню)
2. **Нажмите "Add New Database User"**
3. **Заполните данные**:
   - **Authentication Method**: Password
   - **Username**: `dating_user`
   - **Password**: создайте сложный пароль (например: `DatingApp2024!`)
   - **Database User Privileges**: Atlas admin
4. **Нажмите "Add User"**

#### Настройка сетевого доступа:
1. **Перейдите в "Network Access"** (левое меню)
2. **Нажмите "Add IP Address"**
3. **Выберите "Allow access from anywhere"** (0.0.0.0/0)
4. **Нажмите "Confirm"**

### 2.3. Получение строки подключения

1. **Вернитесь в "Database"** (левое меню)
2. **Нажмите "Connect"** на вашем кластере
3. **Выберите "Connect your application"**
4. **Скопируйте строку подключения**:
   ```
   mongodb+srv://dating_user:<password>@dating-app-cluster.xxxxx.mongodb.net/?retryWrites=true&w=majority
   ```
5. **Замените `<password>`** на ваш реальный пароль
6. **СОХРАНИТЕ эту строку** - она понадобится в конфигурации

---

## 🔧 ЭТАП 3: НАСТРОЙКА ПЕРЕМЕННЫХ ОКРУЖЕНИЯ (5 минут)

### 3.1. Редактирование .env.timeweb

Откройте файл `.env.timeweb` и замените следующие значения:

```env
# MongoDB Atlas - ЗАМЕНИТЕ НА ВАШУ СТРОКУ ПОДКЛЮЧЕНИЯ
MONGODB_URI=mongodb+srv://dating_user:ВАШ_ПАРОЛЬ@dating-app-cluster.xxxxx.mongodb.net/?retryWrites=true&w=majority&appName=dating-app-cluster
MONGODB_DATABASE=dating_app

# MinIO (хранилище файлов) - МОЖЕТЕ ОСТАВИТЬ КАК ЕСТЬ
MINIO_ROOT_USER=minio_admin
MINIO_ROOT_PASSWORD=minio_super_secret_password_2024
AWS_ACCESS_KEY_ID=minio_admin
AWS_SECRET_ACCESS_KEY=minio_super_secret_password_2024
AWS_BUCKET=dating-app-files
AWS_REGION=us-east-1

# ImgProxy (обработка изображений) - МОЖЕТЕ ОСТАВИТЬ КАК ЕСТЬ
IMGPROXY_KEY=943b421c9eb07c830af81030552c86009268de4e532ba2ee2eab8247c6da0881
IMGPROXY_SALT=520f986b998545b4785e0defbc4f3c1203f22de2374a3d53cb7a7fe9fea309c5

# Telegram Bot - ЗАМЕНИТЕ НА ВАШИ ДАННЫЕ
BOT_TOKEN=1234567890:ABCdefGHIjklMNOpqrsTUVwxyz  # Ваш токен от BotFather
BOT_USERNAME=my_dating_app_bot  # Ваш username бота БЕЗ @

# Production URLs - ЗАМЕНИТЕ НА ВАШЕ НАЗВАНИЕ ПРИЛОЖЕНИЯ
VITE_BACKEND_URL=https://my-dating-app.twc1.net/api  # Замените my-dating-app
DOMAIN=my-dating-app.twc1.net  # Замените my-dating-app

# Environment - ОСТАВЬТЕ КАК ЕСТЬ
NODE_ENV=production
PORT=4000
```

### 3.2. Генерация безопасных ключей (опционально)

Если хотите сгенерировать новые ключи для ImgProxy:

**Windows:**
```cmd
generate-timeweb-env.bat
```

**Linux/Mac:**
```bash
chmod +x generate-timeweb-env.sh
./generate-timeweb-env.sh
```

---

## 📤 ЭТАП 4: ПОДГОТОВКА КОДА ДЛЯ РАЗВЕРТЫВАНИЯ (5 минут)

### 4.1. Проверка файлов проекта

Убедитесь, что у вас есть все необходимые файлы:

```
├── backend/                    # Backend API
├── tg-web-app/                # Frontend приложение
├── nginx/                     # Конфигурация Nginx
├── docker-compose.timeweb.yml # Docker Compose для Timeweb
├── Dockerfile.landing         # Dockerfile для лендинга
├── .env.timeweb              # Переменные окружения
├── server.js                 # Сервер лендинга
├── index.html               # Главная страница
└── package.json             # Зависимости корневого проекта
```

### 4.2. Загрузка на GitHub

1. **Создайте новый репозиторий** на GitHub
2. **Инициализируйте Git** (если еще не сделано):
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```
3. **Добавьте remote и загрузите**:
   ```bash
   git remote add origin https://github.com/ваш-username/ваш-репозиторий.git
   git branch -M main
   git push -u origin main
   ```

**ВАЖНО**: Файл `.env.timeweb` НЕ загружается на GitHub (он в .gitignore)

---

## 🌐 ЭТАП 5: РАЗВЕРТЫВАНИЕ НА TIMEWEB CLOUD (20 минут)

### 5.1. Создание аккаунта Timeweb Cloud

1. **Перейдите на** [timeweb.cloud](https://timeweb.cloud)
2. **Зарегистрируйтесь** или войдите в аккаунт
3. **Пополните баланс** (минимум 100 рублей для тестирования)

### 5.2. Создание приложения

1. **Перейдите в раздел** "Облачные приложения"
2. **Нажмите** "Создать приложение"
3. **Выберите** "Подключить GitHub репозиторий"
4. **Авторизуйтесь в GitHub** и выберите ваш репозиторий

### 5.3. Настройка приложения

#### Основные настройки:
- **Название приложения**: `my-dating-app` (или ваше уникальное имя)
- **Тип приложения**: `Docker`
- **Подтип**: `Docker Compose`
- **Путь к docker-compose.yml**: `docker-compose.timeweb.yml`
- **Ветка**: `main`

#### Настройки ресурсов:
- **CPU**: 1 vCPU (минимум)
- **RAM**: 1 GB (минимум)
- **Диск**: 10 GB

### 5.4. Добавление переменных окружения

**КРИТИЧЕСКИ ВАЖНО**: Добавьте ВСЕ переменные из файла `.env.timeweb`:

| Переменная | Значение | Описание |
|------------|----------|----------|
| `MONGODB_URI` | `mongodb+srv://dating_user:ВАШ_ПАРОЛЬ@...` | Строка подключения к MongoDB Atlas |
| `MONGODB_DATABASE` | `dating_app` | Название базы данных |
| `MINIO_ROOT_USER` | `minio_admin` | Пользователь MinIO |
| `MINIO_ROOT_PASSWORD` | `minio_super_secret_password_2024` | Пароль MinIO |
| `AWS_ACCESS_KEY_ID` | `minio_admin` | Access Key для S3 |
| `AWS_SECRET_ACCESS_KEY` | `minio_super_secret_password_2024` | Secret Key для S3 |
| `AWS_BUCKET` | `dating-app-files` | Название S3 bucket |
| `AWS_REGION` | `us-east-1` | Регион S3 |
| `IMGPROXY_KEY` | `943b421c9eb07c830af81030552c86009268de4e532ba2ee2eab8247c6da0881` | Ключ ImgProxy |
| `IMGPROXY_SALT` | `520f986b998545b4785e0defbc4f3c1203f22de2374a3d53cb7a7fe9fea309c5` | Соль ImgProxy |
| `BOT_TOKEN` | `1234567890:ABC...` | Токен Telegram бота |
| `BOT_USERNAME` | `my_dating_app_bot` | Username бота БЕЗ @ |
| `VITE_BACKEND_URL` | `https://my-dating-app.twc1.net/api` | URL API для фронтенда |
| `DOMAIN` | `my-dating-app.twc1.net` | Домен приложения |
| `NODE_ENV` | `production` | Режим работы |
| `PORT` | `4000` | Порт backend |

### 5.5. Запуск развертывания

1. **Проверьте все настройки**
2. **Нажмите** "Создать приложение"
3. **Дождитесь завершения сборки** (5-15 минут)

#### Мониторинг процесса сборки:
- Следите за логами в реальном времени
- Проверьте, что все сервисы запустились:
  - ✅ `mongo` - база данных
  - ✅ `object-storage` - MinIO хранилище
  - ✅ `imgproxy` - обработка изображений
  - ✅ `backend` - API сервер
  - ✅ `frontend` - React приложение
  - ✅ `landing` - лендинг страница
  - ✅ `nginx` - веб-сервер

---

## 🔗 ЭТАП 6: НАСТРОЙКА TELEGRAM BOT ДЛЯ ПРОДАКШЕНА (5 минут)

### 6.1. Получение URL приложения

После успешного развертывания:
1. **Скопируйте URL** вашего приложения (например: `https://my-dating-app.twc1.net`)
2. **Проверьте доступность**:
   - Главная страница: `https://my-dating-app.twc1.net`
   - API health: `https://my-dating-app.twc1.net/api/health`
   - Приложение: `https://my-dating-app.twc1.net/app`

### 6.2. Обновление Web App URL

1. **Найдите @BotFather** в Telegram
2. **Отправьте команду**:
   ```
   /myapps
   ```
3. **Выберите ваше приложение** из списка
4. **Нажмите** "Edit Web App URL"
5. **Введите новый URL**:
   ```
   https://my-dating-app.twc1.net
   ```

### 6.3. Настройка Menu Button

1. **Отправьте команду**:
   ```
   /setmenubutton
   ```
2. **Выберите вашего бота**
3. **Введите текст кнопки**:
   ```
   🔥 Открыть приложение
   ```
4. **Введите URL**:
   ```
   https://my-dating-app.twc1.net
   ```

### 6.4. Настройка Webhook (автоматически)

Webhook настраивается автоматически при запуске backend сервиса по адресу:
```
https://my-dating-app.twc1.net/api/webhook
```

---

## ✅ ЭТАП 7: ТЕСТИРОВАНИЕ И ПРОВЕРКА (10 минут)

### 7.1. Проверка всех компонентов

#### Проверка лендинга:
```
https://my-dating-app.twc1.net
```
Должна открыться красивая главная страница с описанием приложения.

#### Проверка API:
```
https://my-dating-app.twc1.net/api/health
```
Должен вернуть JSON с информацией о статусе API.

#### Проверка приложения:
```
https://my-dating-app.twc1.net/app
```
Должно открыться React приложение.

### 7.2. Тестирование Telegram Bot

1. **Найдите вашего бота** в Telegram
2. **Отправьте** `/start`
3. **Нажмите кнопку** "🔥 Открыть приложение"
4. **Проверьте функции**:
   - ✅ Авторизация через Telegram
   - ✅ Создание профиля
   - ✅ Загрузка фотографий
   - ✅ Просмотр карточек других пользователей
   - ✅ Система лайков
   - ✅ Чат после взаимного лайка

### 7.3. Проверка логов

В панели Timeweb Cloud:
1. **Откройте ваше приложение**
2. **Перейдите на вкладку "Логи"**
3. **Проверьте логи всех сервисов**:
   - `nginx`: успешные HTTP запросы
   - `backend`: подключение к MongoDB, обработка API запросов
   - `frontend`: успешная сборка и запуск
   - `mongo`: успешный запуск базы данных
   - `object-storage`: создание bucket'ов
   - `imgproxy`: готовность к обработке изображений

---

## 🌐 ЭТАП 8: НАСТРОЙКА СОБСТВЕННОГО ДОМЕНА (опционально, 30 минут)

### 8.1. Покупка домена

1. **Выберите регистратора**:
   - [reg.ru](https://reg.ru) (для .ru домена)
   - [namecheap.com](https://namecheap.com) (для международных доменов)
   - [godaddy.com](https://godaddy.com)

2. **Купите домен** (например: `mydatingapp.com`)

### 8.2. Настройка DNS

1. **Войдите в панель управления** вашего регистратора
2. **Найдите раздел DNS** или "Управление DNS"
3. **Добавьте A-запись**:
   - **Тип**: A
   - **Имя**: @ (или оставьте пустым)
   - **Значение**: IP-адрес вашего приложения Timeweb
   - **TTL**: 3600

4. **Добавьте CNAME для www** (опционально):
   - **Тип**: CNAME
   - **Имя**: www
   - **Значение**: ваш-домен.com
   - **TTL**: 3600

### 8.3. Настройка домена в Timeweb

1. **В панели Timeweb Cloud** откройте ваше приложение
2. **Перейдите на вкладку "Домены"**
3. **Нажмите "Добавить домен"**
4. **Введите ваш домен**: `mydatingapp.com`
5. **Дождитесь выпуска SSL сертификата** (5-15 минут)

### 8.4. Обновление конфигурации

Обновите переменные окружения в Timeweb:
- `VITE_BACKEND_URL`: `https://mydatingapp.com/api`
- `DOMAIN`: `mydatingapp.com`

### 8.5. Обновление Telegram Bot

В @BotFather обновите URL:
```
/myapps → выберите приложение → Edit Web App URL → https://mydatingapp.com
```

---

## 🔧 УСТРАНЕНИЕ НЕПОЛАДОК

### Проблема: 502 Bad Gateway

**Причины и решения:**

1. **Сервисы еще запускаются**
   - Подождите 2-3 минуты
   - Проверьте логи всех сервисов

2. **Ошибка в переменных окружения**
   - Проверьте все переменные в панели Timeweb
   - Убедитесь, что нет лишних пробелов

3. **Проблема с MongoDB**
   - Проверьте строку подключения `MONGODB_URI`
   - Убедитесь, что IP разрешен в MongoDB Atlas

### Проблема: Telegram Bot не отвечает

**Решения:**

1. **Проверьте токен бота**
   - Убедитесь, что `BOT_TOKEN` правильный
   - Проверьте, что бот не заблокирован

2. **Проверьте webhook**
   - Откройте: `https://ваш-домен/api/health`
   - Проверьте логи backend сервиса

3. **Обновите URL в @BotFather**
   - Убедитесь, что URL правильный
   - Проверьте, что нет лишних слешей

### Проблема: Не загружаются изображения

**Решения:**

1. **Проверьте MinIO**
   - Проверьте логи `object-storage`
   - Убедитесь, что bucket создался

2. **Проверьте ImgProxy**
   - Проверьте логи `imgproxy`
   - Убедитесь, что ключи правильные

### Проблема: Frontend не загружается

**Решения:**

1. **Проверьте сборку**
   - Посмотрите логи `frontend` сервиса
   - Убедитесь, что `VITE_BACKEND_URL` правильный

2. **Проверьте Nginx**
   - Посмотрите логи `nginx`
   - Убедитесь, что конфигурация правильная

---

## 📊 МОНИТОРИНГ И ПОДДЕРЖКА

### Полезные команды для проверки:

```bash
# Проверка статуса всех сервисов
curl https://ваш-домен/health

# Проверка API
curl https://ваш-домен/api/health

# Проверка ImgProxy
curl https://ваш-домен/imgproxy/health
```

### Мониторинг в Timeweb:

1. **Метрики**: CPU, RAM, диск, сеть
2. **Логи**: в реальном времени для всех сервисов
3. **Алерты**: настройка уведомлений о проблемах

---

## 🎉 ПОЗДРАВЛЯЕМ! ПРИЛОЖЕНИЕ ГОТОВО!

После выполнения всех шагов у вас будет:

✅ **Полнофункциональное приложение для знакомств**  
✅ **Работающее под вашим доменом**  
✅ **Интегрированное с Telegram**  
✅ **С системой платежей**  
✅ **С загрузкой и обработкой фотографий**  
✅ **С чатом в реальном времени**  
✅ **С системой лайков и матчинга**  
✅ **Масштабируемая микросервисная архитектура**  

### Следующие шаги:

1. **Протестируйте все функции** с несколькими пользователями
2. **Настройте мониторинг** и алерты
3. **Создайте резервные копии** данных
4. **Подумайте о маркетинге** и привлечении пользователей
5. **Рассмотрите возможность** добавления новых функций

### Полезные ссылки:

- **Ваше приложение**: `https://ваш-домен`
- **Панель Timeweb**: [timeweb.cloud](https://timeweb.cloud)
- **MongoDB Atlas**: [cloud.mongodb.com](https://cloud.mongodb.com)
- **Документация Telegram Bot API**: [core.telegram.org/bots/api](https://core.telegram.org/bots/api)

**Время развертывания**: ~60-90 минут  
**Стоимость**: ~500-1000 рублей/месяц (Timeweb + домен)  
**Масштабируемость**: до 10,000+ пользователей на базовом плане