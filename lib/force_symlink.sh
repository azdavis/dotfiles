# requires: true.
# ensures: force_symlink x y removes y, if it exists, creates all directory
# components of y, if they do not exist, and symlinks y to point at x.
force_symlink() {
	rm -rf "$2"
	mkdir -p "$(dirname "$2")"
	ln -s "$1" "$2"
}
