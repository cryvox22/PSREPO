write-host "`n"
Write-Host "Willkommen beim Get-Serial-Tool!"
Write-Host "------------------------------------"
write-host "`n"
Write-Host "Ihre Seriennummer wird jetzt ausgelesen..."
write-host "`n"

$serial = (Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber
$serial | clip
Write-Host "Die Seriennummer" $serial "befindet sich jetzt in Ihrer Zwischenablage!"
write-host "`n"