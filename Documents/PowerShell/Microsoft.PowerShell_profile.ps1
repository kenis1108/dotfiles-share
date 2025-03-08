$legacyProfilePath = "$env:USERPROFILE\.config\PowerShell\profile.ps1"
if (Test-Path $legacyProfilePath) {
    . $legacyProfilePath
}
