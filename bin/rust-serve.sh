#!/bin/sh
# Runs miniserve, a static file server written in Rust, as a Custom worker.
# build.sh downloads the prebuilt musl release into the site's home directory.
exec >> public/rust-serve.log 2>&1
echo "rust-serve: start $(date -u) HOME=$HOME PWD=$PWD"
BIN="$HOME/miniserve"
ls -la "$BIN" || echo "rust-serve: binary missing"
"$BIN" --version || echo "rust-serve: version failed with $?"
"$BIN" --interface 0.0.0.0 -p 3002 --route-prefix /rust public
echo "rust-serve: miniserve exited with $?"
