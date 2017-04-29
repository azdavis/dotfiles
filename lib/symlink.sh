symlink() {
	rm -rf "$2"
	mkdir -p "$(dirname "$2")"
	ln -s "$1" "$2"
}
