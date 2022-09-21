write-host "`n"
Write-Host "Willkommen beim Get-MacAddress-Tool!"
Write-Host "------------------------------------"
write-host "`n"

Get-NetAdapter 

$EthAdapterNumber = Read-Host "Wähle einen Adapter aus (1,2,3..)"
write-host "`n"

$intEthAdapterNumber = [int]$EthAdapterNumber
$intEthAdapterNumber = $intEthAdapterNumber-1
$AdapterName = "Ethernet" +$intEthAdapterNumber

if($intEthAdapterNumber-eq 0)
{
$mac =  (Get-NetAdapter -Name Ethernet).macaddress
}
else
{
$mac =  (Get-NetAdapter -Name Ethernet + $intEthAdapterNumber).macaddress
}

Write-Host "Die Mac-Addresse" $mac "befindet sich jetzt in Ihrer Zwischenablage!"
write-host "`n"
$mac | clip







