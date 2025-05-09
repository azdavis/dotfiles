# third party

if [ -e /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# fix vscode shell integration interaction with setopt no_unset

export P9K_SSH
export P9K_TTY
export STARSHIP_SESSION_KEY
export VSCODE_ENV_APPEND
export VSCODE_ENV_PREPEND
export VSCODE_ENV_REPLACE
export VSCODE_SHELL_ENV_REPORTING
export ZSH

# personal

setopt auto_cd
setopt ignore_eof
setopt inc_append_history
setopt interactive_comments
setopt menu_complete
setopt no_beep
setopt no_rcs
setopt no_unset
setopt rm_star_silent

export COPYFILE_DISABLE="1"
export EDITOR="code"
export HOMEBREW_NO_EMOJI="1"
export HOMEBREW_NO_INSECURE_REDIRECT="1"
export LS_COLORS="di=34"
export SAVEHIST="1"
export WORDCHARS="._-~"

export FPATH="$HOME/.site-functions:$FPATH"

PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.volta/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH

export ZLE_SPACE_SUFFIX_CHARS=$'&|'
if [ -z "${SSH_TTY+1}" ]; then
  PS1=$'%{\e[90m%}%2~%{\e[0m%} %{\e[%(?.32.31)m%}%(!.#.$)%{\e[0m%} '
else
  PS1=$'%{\e[33m%}[%m]%{\e[0m%} %{\e[90m%}%2~%{\e[0m%} %{\e[%(?.32.31)m%}%(!.#.$)%{\e[0m%} '
fi

alias -- "-"="cd -"
alias e="$EDITOR"
alias grep="grep --color=auto"

alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gl="git log --ext-diff --graph --oneline"
alias gp="git push"
alias gpl="git pull"
alias gr="git reset"
alias grb="git rebase"
alias grs="git restore"
alias gs="git status"
alias gsw="git switch"
alias gw="git show --ext-diff --format=fuller"

ls() {
  if [ "$#" -eq 1 ] && [ -f "$1" ]; then
    # not that portable
    if head -n 5 "$1" | grep -q '\x00'; then
      echo "<binary file>"
    else
      cat "$1"
    fi
  else
    eza --group-directories-first "$@"
  fi
}

annoy() {
  while say 'alert'; do done
}

mesg n
tabs -4

# autocomplete

autoload -U compinit
compinit -i
zstyle ":completion:*" group-name ""
zstyle ":completion:*" list-dirs-first true
zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"
zstyle ":completion:*" menu select
zstyle ":completion:*" squeeze-slashes true
zstyle ":completion:*" verbose false

_stat() {
  _default "$@"
}

# end
