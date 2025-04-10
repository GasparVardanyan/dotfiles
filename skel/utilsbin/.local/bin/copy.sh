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

		if [ '' != "$files" ]
		then
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
		fi
	done

popd >/dev/null

pushd "$dest" >/dev/null

	find . -type f | while read f
	do
		if [ ! -f "$src/$f" ]
		then
			rm -v "$dest/$f"
		fi
	done

	find . -type d | tac | while read d
	do
		if [ ! -d "$src/$d" ]
		then
			rmdir -v "$dest/$d"
		fi
	done

popd >/dev/null
