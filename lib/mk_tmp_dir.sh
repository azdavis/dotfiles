. ~/.config/lib/rand_int.sh

mk_tmp_dir() {
	x=""
	while true; do
		x="/tmp/$(rand_int 0 999999999)"
		if mkdir -m 700 "$x" 2> /dev/null; then
			break
		fi
	done
	echo "$x"
}
