$target = "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\persist\vscode\data\user-data\User\settings.json"
$source = "$env:USERPROFILE\.config\vscode\settings.json"
Create-SymbolicLinkIfNeeded -TargetPath $target -SourcePath $source

$target = "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\persist\vscode\data\user-data\User\keybindings.json"
$source = "$env:USERPROFILE\.config\vscode\keybindings.json"
Create-SymbolicLinkIfNeeded -TargetPath $target -SourcePath $source