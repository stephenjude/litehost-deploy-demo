#!/bin/sh
# Runs miniserve, a static file server written in Rust, as a Custom worker.
# The binary is a prebuilt musl release, downloaded once into the site's home.
set -e
BIN="$HOME/miniserve"
if [ ! -x "$BIN" ]; then
  curl -fSL -o "$BIN" https://github.com/svenstaro/miniserve/releases/download/v0.35.0/miniserve-0.35.0-x86_64-unknown-linux-musl
  chmod +x "$BIN"
fi
"$BIN" --version
exec "$BIN" --interface 0.0.0.0 -p 3002 --route-prefix /rust public
