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










# Check if fish exists and switch to fish
if command -v fish &> /dev/null
then
  exec fish
fi
