get_github_cred() {
	echo "host=github.com" \
		| git credential fill \
		| grep -F "$1" \
		| sed "s/$1=//"
}
