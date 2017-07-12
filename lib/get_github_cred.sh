get_github_cred() {
	echo "host=github.com" \
		| git credential fill \
		| grep "$1" \
		| sed "s/$1=//"
}
