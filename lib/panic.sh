# requires: true.
# ensures: panic x writes x to stderr and exits the program with failure
# status.
panic() {
	echo "$1" >&2
	exit 1
}
