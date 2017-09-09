panic() {
	echo "$1"
	exit 1
}

rand_int() {
	awk "BEGIN{srand();print int($1+rand()*($2-$1+1))}"
}

mk_temp_dir() {
	x=""
	while true; do
		x="/tmp/$(rand_int 0 999999999)"
		if mkdir -m 700 "$x" > /dev/null 2>&1; then
			break
		fi
	done
	echo "$x"
}

check_user() {
	echo "checking user is not 'root'"
	if [ "$USER" != root ]; then
		return
	fi
	panic "user is 'root'"
}

check_deps() {
	echo "checking deps are installed"
	ok=true
	if [ "$(uname)" = Darwin ] && ! xcode-select -p > /dev/null; then
		echo "'Command Line Developer Tools' not installed"
		ok=false
	fi
	for x in chsh curl git open perl zsh; do
		if ! command -v "$x" > /dev/null; then
			echo "'$x' not installed"
			ok=false
		fi
	done
	if $ok; then
		return
	fi
	panic "not all deps are installed"
}

install_repo() {
	echo "installing '$url' to '$dst'"
	if [ -d "$dst" ] \
	&& [ "$(git -C "$dst" config remote.origin.url)" = "$url" ]; then
		return
	fi
	tmp="$(mk_temp_dir)"
	trap "rmdir '$tmp'" EXIT
	git -c transfer.fsckObjects=true clone -q -n --single-branch "$url" "$tmp"
	if ! [ -d "$dst" ]; then
		rm -f "$dst"
		mkdir "$dst"
	fi
	chmod 700 "$dst"
	rm -rf "$dst/.git"
	mv "$tmp/.git" "$dst/.git"
	git -C "$dst" reset -q --hard
}

do_home() {
	echo "doing home actions"
	"$dst/bin/do-home"
}

do_subl() {
	echo "doing subl actions"
	"$dst/bin/do-subl"
}

change_shell() {
	new_shell="$(command -v zsh)"
	echo "changing shell to '$new_shell'"
	if [ "$SHELL" = "$new_shell" ]; then
		return
	fi
	chsh -s "$new_shell" < /dev/tty
}

main() {
	set -eu
	url="https://github.com/azdavis/dotfiles.git"
	dst="$HOME/.config"
	check_user
	check_deps
	install_repo
	do_home
	do_subl
	change_shell
	echo "finishing"
}

main
