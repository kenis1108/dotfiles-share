#---------------------------------------
# alias
#---------------------------------------
# Replace ls with eza
alias ls 'eza -al --color=always --group-directories-first --icons' # preferred listing
alias la 'eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll 'eza -l --color=always --group-directories-first --icons'  # long format
alias lt 'eza -aT --color=always --group-directories-first --icons' # tree listing
alias l. 'eza -ald --color=always --group-directories-first --icons .*' # show only dotfiles

# chezmoi
alias cc 'cd (chezmoi source-path)'
alias ca 'chezmoi apply --force'
alias ce 'chezmoi edit --apply'

# grep
alias grep 'grep --color=auto'

# git
function gcp
  git add .
  git commit -m "$argv"
  git push
end
alias gp 'git pull'

# lazygit
alias lg 'lazygit'

# zellij
alias zj 'zellij'

# proxy
function set-proxy
    set -gx PROXY_IP "192.168.93.14:7897"
    set -gx http_proxy  "http://$PROXY_IP"
    set -gx https_proxy "http://$PROXY_IP"
    set -gx all_proxy   "socks5://$PROXY_IP"
    echo "✅ 代理已设置为：$PROXY_IP"
end

function unset-proxy
    # 清除所有代理相关的环境变量
    set -e PROXY_IP
    set -e http_proxy
    set -e https_proxy
    set -e all_proxy

    # 可选：提示代理已取消  
    echo "🗑️ 代理设置已清除！"
end

# 中证VPN
alias dhip 'sudo dhclient vpn_test; and sh /home/kk/vpn/iproute.sh'
alias startvpn 'cd; and cd vpn/vpnclient; and sudo ./vpnclient start; and sudo ./vpncmd'
# 山西证券子公司VPN
alias motion '/opt/MotionPro/MotionPro.sh'
# 鸽子内网穿透
alias startnpc 'cd ~/Downloads/linux_amd64_client; and ./npc -server=f1.fgct.cc:8024 -vkey=159abe614d'
# 使ranger退出时停留在选中的目录中
alias ranger 'ranger --choosedir=$HOME/.rangerdir; and set -l LASTDIR (cat $HOME/.rangerdir); and cd "$LASTDIR"'
