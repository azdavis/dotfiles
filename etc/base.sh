set -o errexit
set -o nounset
set -o pipefail
set -o posix

abort() {
    echo "$1"
    exit 1
}
