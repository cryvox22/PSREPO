
#Change-IPAddressStein
function ChangeIPAddress{

$InterfaceIndex = 5

Write-Host -ForegroundColor Cyan "Dieses Tool hilft Ihnen ihre IP-Adresse passend für die Siemens SmartClient anzupassen!"
Write-Host ""
Write-Host -ForegroundColor Cyan "Folgende Adressen haben Sie zur Auswahl:"
Write-host -ForegroundColor Green "[1] - PIA Hauptmaschine - 192.168.0.55"
Write-host -ForegroundColor Green "[2] - PIA Hauptmaschine - 192.168.0.8"
Write-host -ForegroundColor Green "[3] - PIA Hauptmaschine - 192.168.0.9"
Write-host -ForegroundColor Green "[4] - Standard (Automatisch)"
Write-Host ""
Write-Host -NoNewline -ForegroundColor Cyan "Bitte geben Sie die entsprechende Nummer ein: "
$Input1 = Read-Host

switch ($Input1)
{
1{ 
    
    New-NetIPAddress -InterfaceIndex $InterfaceIndex -IPAddress 192.168.0.55 -PrefixLength 24
    Write-Host -ForegroundColor Cyan "Die IP-Adresse wurde angepasst!"
    ; Break}
2{
    New-NetIPAddress -InterfaceIndex $InterfaceIndex -IPAddress 192.168.0.8 -PrefixLength 24
    Write-Host -ForegroundColor Cyan "Die IP-Adresse wurde angepasst!"
    ; Break}
3{
    New-NetIPAddress -InterfaceIndex $InterfaceIndex -IPAddress 192.168.0.9 -PrefixLength 24
    Write-Host -ForegroundColor Cyan "Die IP-Adresse wurde angepasst!"
    ; Break}

4{
    Set-NetIPInterface -InterfaceIndex $InterfaceIndex  -Dhcp Enabled
    Write-Hoste -ForegroundColor Cyan "Die IP-Adresse wurde wieder auf Standard gesetzt!"

}

Default {    Write-Host -ForegroundColor Cyan "Keine Übereinstimmung" }

}


}

ChangeIPAddress