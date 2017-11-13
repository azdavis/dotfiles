# requires: true.
# ensures: cmd_found x returns whether using x as a command in the current
# shell would NOT give a "command not found" error.
cmd_found() {
	command -v "$1" > /dev/null
}
