#!/usr/bin/env bash

find . -type f -name 'package-gaspar-*' | xargs -L 1 makepkg -cdp
find . -type f -name 'gaspar-*.pkg.tar.zst' | xargs -L 1 repo-add gaspar.db.tar.zst
