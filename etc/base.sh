set -o errexit
set -o nounset
set -o pipefail
set -o posix
IFS=$'\n\t'

abort() {
    echo "error: $1"
    exit 1
}
