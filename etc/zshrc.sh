setopt autocd
setopt ignoreeof
setopt interactivecomments
setopt menucomplete
setopt nobeep
setopt norcs
setopt nounset
setopt rmstarsilent

export COPYFILE_DISABLE="1"
export EDITOR="code"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_NO_EMOJI="1"
export HOMEBREW_NO_INSECURE_REDIRECT="1"
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LESS="-FRSsqx2"
export LESSCHARSET="UTF-8"
export LESSHISTFILE="/dev/null"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=7;36:cd=7;33:su=7;31:sg=7;36:tw=7;32:ow=7;33:st=7;34"
export RLWRAP_HOME="/dev/null"
export WORDCHARS="._-~"

PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/dotfiles/bin:$PATH"
export PATH

ZLE_REMOVE_SUFFIX_CHARS=$' \t\n;'
if [ -z "${SSH_TTY+1}" ]; then
  PS1=$'%{\e[90m%}%2~%{\e[0m%} %{\e[%(?.32.31)m%}%(!.#.$)%{\e[0m%} '
else
  PS1=$'%{\e[33m%}[%m]%{\e[0m%} %{\e[90m%}%2~%{\e[0m%} %{\e[%(?.32.31)m%}%(!.#.$)%{\e[0m%} '
fi

alias -- -="cd -"
alias e="code"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gf="git fetch"
alias gh="git show --format=fuller"
alias gi="git init"
alias gk="git checkout"
alias gl="git log --all --graph --oneline"
alias gm="git merge"
alias gp="git push"
alias gpl="git pull"
alias gr="git reset"
alias grb="git rebase"
alias grep="grep --color=auto"
alias gs="git status"
alias gt="git tag"
alias ls="exa --group-directories-first"

autoload -U compinit
compinit -i
zstyle ":completion:*" group-name ""
zstyle ":completion:*" list-dirs-first true
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"
zstyle ":completion:*" menu select
zstyle ":completion:*" squeeze-slashes true
zstyle ":completion:*" verbose false

# fix bad autocomplete
_stat() {
  _default "$@"
}

mesg n
tabs -2

if [ -f "$HOME/e" ]; then
  cat "$HOME/e"
fi

# end
