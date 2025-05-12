#!/usr/bin/env bash

find . -name '*.pkg.tar.zst' -or -name 'gaspar.*' | xargs rm
