#!/usr/bin/env bash

find . -type f -name 'package-gaspar-*' | while read pkgbuild
do
	echo "BUILDING $pkgbuild"
	makepkg -cdp "$pkgbuild" && repo-add gaspar.db.tar.zst "${pkgbuild#*-}"*.pkg.tar.zst
done

# find . -type f -name 'gaspar-*.pkg.tar.zst' | xargs -L 1 repo-add gaspar.db.tar.zst
