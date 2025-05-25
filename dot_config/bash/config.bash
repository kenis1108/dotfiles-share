#------------------------
# environment variables
#------------------------
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

#--------------------
# prompt
#--------------------
eval "$(starship init bash)"

#-------------------
# alias
#-------------------
# chezmoi
alias cc='cd $(chezmoi source-path)'
alias ca='chezmoi apply --force'
alias ce='chezmoi edit --apply'

# grep
alias grep='grep --color=auto'

# git
function gcp() {
  git add .
  git commit -m "$1"
  git push
}
alias gp='git pull'

# lazygit
alias lg='lazygit'

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# uv
if command -v uv &> /dev/null; then
  eval "$(uv generate-shell-completion bash)"
  eval "$(uvx --generate-shell-completion bash)"
fi

# fnm
FNM_PATH="~/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd --shell bash)"
  eval "$(fnm completions --shell bash)"
fi


# Check if fish exists and switch to fish
if command -v fish &> /dev/null; then
  exec fish
fi
