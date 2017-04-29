set -eu

abort() {
	echo "$1" 1>&2
	exit 1
}
