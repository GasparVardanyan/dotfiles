if [ -d "/usr/local/etc/nspawn/userconfig/$MACHINE" ] ; then
	find "/usr/local/etc/nspawn/userconfig/$MACHINE" -type f -name "*.sh" \
		| sort -n -t / -k 8n \
		| while read f
		do
			source "$f"
		done
fi
