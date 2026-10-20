#!/bin/sh
# Build step: records the deployed commit so the page can show it.
git rev-parse --short HEAD > BUILD
