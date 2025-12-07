#!/usr/bin/env bash

src=$(realpath "$1")
dest=$(realpath "$2")

pushd "$src" >/dev/null

	dirs=$(find . -type d)

	echo "$dirs" | while read d
	do
		echo mkdir -p -v "$dest/$d"
	done

	files=$(find . -type f)

	if [ '' != "$files" ]
	then
		echo "$files" | while read f
		do
			if [ ! -f "$dest/$f" ]
			then
				echo new cp -v "$f" "$dest/$f"
			elif [ "$f" -nt "$dest/$f" ]
			then
				cmp -s "$f" "$dest/$f"		\
				||							\
					echo diff cp -v "$f" "$dest/$f"
			fi
			# cp --attributes-only --preserve "$f" "$dest/$f"
		done
	fi

popd >/dev/null

pushd "$dest" >/dev/null

	find . -type f | while read f
	do
		if [ ! -f "$src/$f" ]
		then
			echo rm -v "$dest/$f"
		fi
	done

	find . -type d | tac | while read d
	do
		if [ ! -d "$src/$d" ]
		then
			echo rmdir -v "$dest/$d"
		fi
	done

popd >/dev/null
