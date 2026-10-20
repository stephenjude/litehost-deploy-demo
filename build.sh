#!/bin/sh
# Litehost build step: runs inside the site container on every deploy.
set -e
git rev-parse --short HEAD > BUILD
composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader
[ -f .env ] || { cp .env.litehost .env && php artisan key:generate --no-interaction; }
touch database/database.sqlite
php artisan optimize
