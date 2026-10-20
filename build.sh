#!/bin/sh
# Litehost build step: runs inside the site container on every deploy.
set -e
git rev-parse --short HEAD > BUILD
composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader
# Carry the .env (and APP_KEY) forward from the previous deploy; first deploy seeds it.
if [ ! -f .env ]; then
  if [ -f ../current/.env ]; then cp ../current/.env .env; else cp .env.litehost .env && php artisan key:generate --no-interaction; fi
fi
touch database/database.sqlite
php artisan optimize
