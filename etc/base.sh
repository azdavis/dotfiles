set -o errexit
set -o nounset
set -o pipefail
set -o posix
IFS=$'\n\t'

abort() {
    echo "$1"
    exit 1
}
