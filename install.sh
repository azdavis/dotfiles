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

cmd_found() {
	command -v "$1" > /dev/null
}

check_user() {
	echo "checking user is not 'root'"
	if [ "$LOGNAME" != root ]; then
		return
	fi
	panic "user is 'root'"
}

find_deps() {
	echo "finding dependencies"
	ok=true
	if cmd_found xcode-select && ! xcode-select -p > /dev/null; then
		echo "'Command Line Developer Tools' not found"
		ok=false
	fi
	for x in chsh git zsh; do
		if ! cmd_found "$x"; then
			echo "'$x' not found"
			ok=false
		fi
	done
	if ! [ -f /bin/sh ]; then
		echo "'/bin/sh' not found"
		ok=false
	fi
	if $ok; then
		return
	fi
	panic "not all dependencies were found"
}

install_repo() {
	echo "installing '$url' to '$dst'"
	if [ -d "$dst" ] \
	&& [ "$(git -C "$dst" config remote.origin.url)" = "$url" ]; then
		return
	fi
	tmp="$(mk_temp_dir)"
	trap "rm -r '$tmp'" EXIT
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
	find_deps
	install_repo
	do_home
	do_subl
	change_shell
	echo "finishing"
}

main
