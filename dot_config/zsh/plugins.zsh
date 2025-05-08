#--------------------
# plugins 
#--------------------
if [ ! -d "$ZSH/plugins" ]; then
  mkdir -p $ZSH/plugins
fi

if [ ! -d "$ZSH/plugins/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://gitee.com/wang_xianjun/zsh-syntax-highlighting.git $ZSH/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$ZSH/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://gitee.com/wang_xianjun/zsh-autosuggestions.git $ZSH/plugins/zsh-autosuggestions
fi

source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


