#---------
# Prompt
#---------
# oh-my-posh via "scoop install oh-my-posh"
# oh-my-posh init pwsh --config ~/.jandedobbeleer.omp.json | Invoke-Expression

# starship
# Check if Starship is installed
if (Get-Command starship -ErrorAction SilentlyContinue) {
  # If Starship is installed, initialize it
  Invoke-Expression (&starship init powershell)
}
else {
  Write-Output "Starship is not installed. If you need to use Starship, please install it first. (scoop install starship)"
}