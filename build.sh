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
# Prebuilt Rust binary for the Custom worker demo, fetched once into the home dir.
if [ ! -x "$HOME/miniserve" ]; then
  curl -fSL -o "$HOME/miniserve" https://github.com/svenstaro/miniserve/releases/download/v0.35.0/miniserve-0.35.0-x86_64-unknown-linux-musl
  chmod +x "$HOME/miniserve"
fi
