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