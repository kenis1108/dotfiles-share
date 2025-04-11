/*
 * @Author: kenis kenisdsg1108@gmail.com
 * @Date: 2025-03-31 09:57:09
 * @LastEditors: kenis kenisdsg1108@gmail.com
 * @LastEditTime: 2025-04-09 16:19:08
 * @FilePath: \chezmoi\dot_custom-scripts\setup-vscode-config.ps1
 * @Description: 
 * This script creates symbolic links for VSCode settings and keybindings files.
 * 
 * Ensure that you run this script as an administrator to avoid permission-related issues.
 * 请确保以管理员身份运行此脚本，以避免与权限相关的问题。
 * 
 * Run this script in a PowerShell session with administrative privileges.
 * 在具有管理员权限的 PowerShell 会话中运行此脚本。
 */

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
    }

    # 创建符号链接
    New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SourcePath
}

$target = "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\persist\vscode\data\user-data\User\settings.json"
$source = "$env:USERPROFILE\.config\vscode\settings.json"
Create-SymbolicLinkIfNeeded -TargetPath $target -SourcePath $source

$target = "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\persist\vscode\data\user-data\User\keybindings.json"
$source = "$env:USERPROFILE\.config\vscode\keybindings.json"
Create-SymbolicLinkIfNeeded -TargetPath $target -SourcePath $source