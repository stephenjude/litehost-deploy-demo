#!/bin/sh
# Runs miniserve, a static file server written in Rust, as a Custom worker.
# build.sh downloads the prebuilt musl release into the site's home directory.
exec "$HOME/miniserve" --interfaces 0.0.0.0 -p 3002 --route-prefix /rust public
