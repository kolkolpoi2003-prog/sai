# Инструкция по деплою на VPS (Ubuntu/Debian)

Эта инструкция поможет вам развернуть сайт на чистом VPS с использованием Docker.

## 1. Подготовка VPS

Зайдите на ваш VPS по SSH:
```bash
ssh root@37.252.19.159
```

Обновите систему и установите Docker:
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io docker-compose git
sudo systemctl enable --now docker
```

## 2. Копирование проекта

Склонируйте ваш репозиторий или загрузите файлы проекта на VPS в папку `/app`:
```bash
mkdir /app
cd /app
# Загрузите сюда файлы (через git clone или scp)
```

## 3. Настройка окружения

Создайте файл `.env` на основе примера:
```bash
cp .env.example .env
nano .env
```
Замените `yoursecretkeyhere` на длинный случайный ключ. Убедитесь, что `ALLOWED_HOSTS` и `CSRF_TRUSTED_ORIGINS` содержат ваш домен.

## 4. Первый запуск и получение SSL (Let's Encrypt)

Для первого запуска (когда сертификатов еще нет) Nginx может выдать ошибку. Чтобы получить сертификат:

1. Временно закомментируйте блок `listen 443 ssl` в `nginx/default.conf`.
2. Запустите Nginx и Certbot:
```bash
docker-compose up -d nginx certbot
```
3. Выполните команду получения сертификата:
```bash
docker-compose run --rm certbot certonly --webroot --webroot-path=/var/www/certbot -d yarko-solntse.ru -d www.yarko-solntse.ru --email vladimirshurkk@gmail.com --agree-tos --no-eff-email
```
4. После успешного получения верните настройки `nginx/default.conf` (раскомментируйте блок 443) и перезапустите:
```bash
docker-compose restart nginx
```

## 5. Полный запуск

Запустите все сервисы:
```bash
docker-compose up -d --build
```

Примените миграции и соберите статику (внутри контейнера):
```bash
docker-compose exec web python manage.py migrate
docker-compose exec web python manage.py createsuperuser
```

## Полезные команды
- `docker-compose logs -f` — просмотр логов в реальном времени.
- `docker-compose restart web` — перезапуск только приложения (например, после обновления кода).
- `docker-compose down` — полная остановка проекта.
