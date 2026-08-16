# $ENV:STARSHIP_CONFIG = "C:\Users\lcavalcanti\OneDrive - Microsoft\Documents\PowerShell\starship.toml"
Invoke-Expression (&starship init powershell)

Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -Colors @{ InlinePrediction = $PSStyle.Foreground.White }
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

# Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete