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

$target = "$env:USERPROFILE\scoop\persist\vscode\data\user-data\User\settings.json"
$source = "$env:USERPROFILE\.config\vscode\settings.json"
Create-SymbolicLinkIfNeeded -TargetPath $target -SourcePath $source

$target = "$env:USERPROFILE\scoop\persist\vscode\data\user-data\User\keybindings.json"
$source = "$env:USERPROFILE\.config\vscode\keybindings.json"
Create-SymbolicLinkIfNeeded -TargetPath $target -SourcePath $source