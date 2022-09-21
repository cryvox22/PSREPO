write-host "`n"
Write-Host "Willkommen beim Get-IPAddress-Tool!"
Write-Host "------------------------------------"
write-host "`n"



$ip =  (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).ipaddress


Write-Host "Die IP-Addresse" $ip "befindet sich jetzt in Ihrer Zwischenablage!"
write-host "`n"
$ip | clip


