check_user() {
	echo "checking user is not 'root'"
	if [ "$USER" != root ]; then
		return
	fi
	echo "user is 'root'"
	exit 1
}

check_os() {
	echo "checking OS is 'macOS'"
	if [ "$(uname)" = Darwin ]; then
		return
	fi
	echo "OS is not 'macOS'"
	exit 1
}

check_deps() {
	echo "checking deps are installed"
	ok=true
	if ! xcode-select -p > /dev/null 2>&1; then
		echo "'Command Line Developer Tools' not installed"
		ok=false
	fi
	for x in \
		basename brew cat chmod chsh curl date defaults dirname find git grep \
		ln mkdir mktemp mv pgrep readlink rm sed sh touch tr wc zsh \
	; do
		if ! command -v "$x" > /dev/null 2>&1; then
			echo "'$x' not installed"
			ok=false
		fi
	done
	if $ok; then
		return
	fi
	echo "not all deps are installed"
	exit 1
}

install_repo() {
	echo "installing '$url' to '$dst'"
	if [ -d "$dst" ] \
	&& [ "$(git -C "$dst" config remote.origin.url)" = "$url" ]; then
		return
	fi
	tmp="$(mktemp -d /tmp/XXXXXXXXXX)"
	trap "rm -rf '$tmp'" EXIT
	git clone -q -n --single-branch "$url" "$tmp"
	if ! [ -d "$dst" ]; then
		rm -rf "$dst"
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
	check_os
	check_deps
	install_repo
	do_home
	do_subl
	change_shell
	echo "finishing"
}

main
