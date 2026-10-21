#!/bin/sh
# Litehost build step: runs inside the site container on every deploy.
set -e
git rev-parse --short HEAD > BUILD

# ~/shared holds what every release shares: .env, storage and the SQLite file
SHARED=../../shared
mkdir -p $SHARED
[ -d $SHARED/storage ] || cp -R storage $SHARED/storage
rm -rf storage
ln -s $SHARED/storage storage
touch $SHARED/database.sqlite
ln -sf ../$SHARED/database.sqlite database/database.sqlite

FIRST_DEPLOY=
if [ ! -f $SHARED/.env ]; then
  cp .env.litehost $SHARED/.env
  FIRST_DEPLOY=1
fi
ln -sf $SHARED/.env .env

composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

if [ -n "$FIRST_DEPLOY" ]; then
  php artisan key:generate --force --no-interaction
  echo "First deploy: fill in ~/shared/.env, then press Deploy now again."
  exit 1
fi

[ -f ../current/rr ] && cp ../current/rr rr || true
php artisan migrate --force
php artisan storage:link
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
