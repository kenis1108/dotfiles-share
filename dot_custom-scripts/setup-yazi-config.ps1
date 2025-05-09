$target = "$env:USERPROFILE\AppData\Roaming\yazi\config\yazi.toml"
$source = "$env:USERPROFILE\.config\yazi\yazi.toml"
Create-SymbolicLinkIfNeeded -TargetPath $target -SourcePath $source
