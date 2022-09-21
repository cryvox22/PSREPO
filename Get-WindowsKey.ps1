write-host "`n"
Write-Host "Willkommen beim Get-WindowsKey-Tool!"
Write-Host "------------------------------------"
write-host "`n"
Write-Host "Ihr Key wird jetzt ausgelesen..."
write-host "`n"

$WindowsKey = (Get-WmiObject -query 'select * from SoftwareLicensingService‘).OA3xOriginalProductKey
$WindowsKey | clip
Write-Host "Der Windows-Key" $WindowsKey "befindet sich jetzt in Ihrer Zwischenablage!"
write-host "`n"
pause