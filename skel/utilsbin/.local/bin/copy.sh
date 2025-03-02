#!/usr/bin/env bash

src=$(realpath "$1")
dest=$(realpath "$2")

pushd "$src" >/dev/null

	dirs=$(find . -type d)

	echo "$dirs" | while read d
	do
		mkdir -p -v "$dest/$d"
	done

	echo "$dirs" | while read d
	do
		files=$(find "$d" -type f)

		echo "$files" | while read f
		do
			if [ ! -f "$dest/$f" ]
			then
				cp -v "$f" "$dest/$f"
			elif [ "$f" -nt "$dest/$f" ]
			then
				cmp -s "$f" "$dest/$f"		\
				||							\
					cp -v "$f" "$dest/$f"
			fi
		done
	done

popd >/dev/null

pushd "$dest" >/dev/null

	find . -type f | while read f
	do
		if [ ! -f "$src/$f" ]
		then
			echo rm "$src/$f"
		fi
	done

	find . -type d | while read d
	do
		if [ ! -d "$src/$d" ]
		then
			echo rmdir "$src/$d"
		fi
	done

popd >/dev/null
