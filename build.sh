#!/bin/sh
# Litehost build step: runs inside the site container on every deploy.
set -e
git rev-parse --short HEAD > BUILD
composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader
# Carry the .env (and APP_KEY) and the RoadRunner binary forward from the previous deploy.
if [ ! -f .env ]; then
  if [ -f ../current/.env ]; then cp ../current/.env .env; else cp .env.litehost .env && php artisan key:generate --no-interaction; fi
fi
[ -f ../current/rr ] && cp ../current/rr rr || true
touch database/database.sqlite
php artisan optimize
# Ask the long-running workers to exit; the platform restarts them in the new release.
php artisan queue:restart
php artisan horizon:terminate
php artisan reverb:restart
