export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

#--------------------
# prompt
#--------------------
eval "$(starship init bash)"

# Check if fish exists and switch to fish
if command -v fish &> /dev/null
then
  exec fish
fi
