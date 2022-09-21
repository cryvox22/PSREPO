write-host "`n"
Write-Host "Willkommen beim Get-InstallDate-Tool!"
Write-Host "------------------------------------"
write-host "`n"
Write-Host "Ihr Installations-Datum wird jetzt ausgelesen..."
write-host "`n"

$installdate = (Get-WmiObject Win32_OperatingSystem).ConvertToDateTime( (Get-WmiObject Win32_OperatingSystem).InstallDate ) 
$installdate | clip

Write-Host -NoNewline "Die Installations-Datum " 
Write-Host -NoNewline -ForegroundColor Yellow $installdate
Write-Host  " befindet sich jetzt in Ihrer Zwischenablage!"
write-host "`n"

