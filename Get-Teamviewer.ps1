write-host "`n"
Write-Host "Willkommen beim Get-TeamViewer-Tool!"
Write-Host "------------------------------------"
write-host "`n"
Write-Host "Der TeamViewer wird installiert..."
write-host "`n"

$DownloadURL = "https://slsvde-my.sharepoint.com/:f:/g/personal/p_gentner_sl-sv_de/Eq5avOtKgE9AnErMrNvooYsB0yUaK196mGYk9xVBlohFEg?e=sg3HJq"



$InstallFilePath = Invoke-WebRequest -Uri $DownloadURL -OutFile TeamViewer.msi

$Argumentlist = '/I C:\TeamViewer.msi /passive APITOKEN=19910524-dWzmY4xQ3FvO8WbjoOyG CUSTOMCONFIGID=6834ixj ASSIGNMENTOPTIONS="--alias %ComputerName% --grant-easy-access"'

Start-Process msiexec.exe -Wait -ArgumentList $Argumentlist

#.\TeamViewer.msi /qn APITOKEN=19910524-dWzmY4xQ3FvO8WbjoOyG CUSTOMCONFIGID=6834ixj ASSIGNMENTOPTIONS="--alias %ComputerName% --grant-easy-access"
Read-Host