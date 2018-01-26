is_int() {
	[ -n "$1" ] && [ "$1" -eq "$1" ] 2>/dev/null
}
