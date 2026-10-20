#!/bin/sh
# Runs miniserve, a static file server written in Rust, as a Custom worker.
# build.sh downloads the prebuilt musl release into the site's home directory.
echo "rust-serve: start HOME=$HOME PWD=$PWD SHELL=$0"
BIN="$HOME/miniserve"
ls -la "$BIN" || echo "rust-serve: binary missing"
"$BIN" --version || echo "rust-serve: version failed with $?"
exec "$BIN" --interface 0.0.0.0 -p 3002 --route-prefix /rust public
