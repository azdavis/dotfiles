# requires: true.
# ensures: is_int x returns whether x is an integer.
is_int() {
	[ "$1" -eq "$1" ] 2> /dev/null
}
