write-host "`n"
Write-Host "Willkommen beim Get-OS-Tool!"
Write-Host "------------------------------------"
write-host "`n"
Write-Host "Ihr Betriebssystem wird jetzt ausgelesen..."
write-host "`n"

$os = (Get-WMIObject win32_operatingsystem).caption
$os | clip

Write-Host "Die Betriebssystemversion" $os "befindet sich jetzt in Ihrer Zwischenablage!"
write-host "`n"

