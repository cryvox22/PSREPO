write-host "`n"
Write-Host -ForegroundColor Green "Willkommen beim Connect-ServerEye!"
Write-Host "------------------------------------"
write-host "`n"
Write-Host -ForegroundColor Blue "Der TeamViewer wird installiert..."
write-host "`n"

#https://servereye.freshdesk.com/support/solutions/articles/14000070083-installation-powershell-helper-modul
#https://servereye.freshdesk.com/support/solutions/articles/14000088986-anlegen-einer-alarmierung-bei-allen-sensoren-eines-kunden-mit-verz%C3%B6gerung-und-filterung-nach-tags-


if (!(Get-Module "ServerEye.Powershell.Helper")) {
    # module is not loaded
    Install-Module -Name ServerEye.Powershell.Helper
}
Import-Module -Name ServerEye.Powershell.Helper
Update-SEHelper

Connect-SESession -persist


Write-Host -ForegroundColor Blue "Liste Kunden auf..."
Get-SECustomer

#Write-Host -ForegroundColor Blue -NoNewline "Moechtest du eine Alarmierung hinzufügen? (J/N)"
#$input1 = Read-Host 
#if($input1 -eq "j" -or $input1 -eq "J"){
#    Write-Host -ForegroundColor Blue -NoNewline "Bitte gib den Kundennamen ein"
#    $inputCustomer = Read-Host
#    Get-SECustomer -Filter $inputCustomer | Get-Sensor -Filter * | New-SENotification -UserID
#}

Read-Host