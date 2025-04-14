#---------
# Alias
#---------

# chezmoi
function cc { Set-Location $(chezmoi source-path) }
function ca { chezmoi apply --force }
function ce { 
  param (
    [Parameter(Mandatory = $true)]
    [ValidateScript({ Test-Path $_ -PathType Leaf }, ErrorMessage = "The path '{0}' is not a valid file path.")]
    [string]$FilePath
  )
  chezmoi edit --apply $FilePath
}

# scoop
function sip {
  scoop install $(scoop search | awk '{print $1}' | fzf)
}

function sup {
  scoop uninstall $(scoop list | awk '{print $1}' | fzf)
}

# yazi
function y {
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}

# git
function gcp() {
  param (
    [string]$message
  )
  git add .
  git commit -m $message
  git push
}

# lazygit
function lg {
  param (
    [string]$path = $PWD.Path
  )
  if (Test-Path -Path $path) {
    Set-Location -LiteralPath $path
    lazygit
  } else {
    Write-Host "路径不存在: $path"
  }
}

# 获取窗口进程id，ProcessName，MainWindowTitle
function gwp {
  Get-Process | Where-Object { $_.MainWindowTitle } | Select-Object Id, ProcessName, MainWindowTitle
}

# 代理
function setproxy {
  $proxyUrl = "http://192.168.243.14:7897"
  $env:HTTP_PROXY = $proxyUrl
  $env:HTTPS_PROXY = $proxyUrl
  Write-Output "proxy设置成功"
}

function unsetproxy { 
  $env:HTTP_proxy = ""
  $env:HTTPS_proxy = "" 
  Write-Output "proxy重置成功"
}
