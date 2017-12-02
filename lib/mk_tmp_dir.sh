. "$HOME/.config/lib/rand_int.sh"

# requires: true.
# ensures: mk_tmp_dir makes a randomly named directory in /tmp with 700
# permissions and prints the directory path to stdout.
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
