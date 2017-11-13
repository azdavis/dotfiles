# requires: true.
# ensures: get_github_cred x prints the github credential x to stdout, if x
# exists in the git credential-storing mechanism defined by git config
# credential.helper.
get_github_cred() {
	echo "host=github.com" \
		| git credential fill \
		| grep -F "$1" \
		| sed "s/$1=//"
}
