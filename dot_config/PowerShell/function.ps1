#-----------------------------
# Custom PowerShell Functions
#-----------------------------
function helloWorld {
	Clear-Host
	Write-Output ""
	Write-Output "|\     /||\     /|(  ___  )( (    /|(  ____ \\__    _/|\     /|"
	Write-Output "| )   ( || )   ( || (   ) ||  \  ( || (    \/   )  (  | )   ( |"
	Write-Output "| (___) || |   | || (___) ||   \ | || |         |  |  | (___) |"
	Write-Output "|  ___  || |   | ||  ___  || (\ \) || | ____    |  |  |  ___  |"
	Write-Output "| (   ) || |   | || (   ) || | \   || | \_  )   |  |  | (   ) |"
	Write-Output "| )   ( || (___) || )   ( || )  \  || (___) ||\_)  )  | )   ( |"
	Write-Output "|/     \|(_______)|/     \||/    )_)(_______)(____/   |/     \|"
	Write-Output ""
	Write-Output " = = = = = = = = = = = = = 命令清单 = = = = = = = = = = = = =  "
	Write-Output " scrcpy查看usb连接是否成功 ------ adbusb"
	Write-Output " 息屏启动scrcpy-s ------ scrcpy"
	Write-Output " ffmpeg下载m3u8成mp4 ------ ffmpeg2mp4 url filename"
	Write-Output " 获取所有窗口的id,进程名,窗口标题 ------ gwp"
	Write-Output " "
}

# 获取所有窗口的id,进程名,窗口标题，以便配置glazewm的窗口规则
function Get-ProcessNameAndMainWindowTitle {
	Get-Process | Where-Object { $_.MainWindowTitle } | Select-Object Id, ProcessName, MainWindowTitle
}

# 为文件创建符号链接，用于在Windows下复用和统一Linux的各种配置文件路径，需要以管理员身份运行这个函数
# 例如：
# $target = "$env:USERPROFILE\AppData\Roaming\yazi\config\yazi.toml"
# $source = "$env:USERPROFILE\.config\yazi\yazi.toml"
# gsudo Create-SymbolicLinkIfNeeded -TargetPath $target -SourcePath $source
function Create-SymbolicLinkIfNeeded {
    param (
        [Parameter(Mandatory = $true)]
        [string]$TargetPath,
        [Parameter(Mandatory = $true)]
        [string]$SourcePath
    )

    # 检查目标路径是否存在
    if (Test-Path -Path $TargetPath) {
        # 如果存在，删除它
        Remove-Item -Path $TargetPath -Force
    }else{
        # 如果不存在，创建父目录
        $parentDir = Split-Path -Path $TargetPath -Parent
        if (-not (Test-Path -Path $parentDir)) {
            New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
        }
    }

    # 创建符号链接
    New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SourcePath
}