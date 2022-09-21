Import-Module ExcahngeOnlineManagement
Connect-ExchangeOnline 


Write-Host "Willkommen beim ExOnline Kalender Get-Add!"
Write-Host "------------------------------------------"
Write-Host "`n"
Write-Host "`n"
Write-Host "`n"



$condition1 = 'J'

while($condition1 -eq 'J' -or $condition1 -eq 'j'){

Write-Host "Was möchten Sie tun?"

Write-Host "------------------------------------------"
Write-Host "`n"
Write-Host "`n"
Write-Host "1. Postfachkalenderberechtigung auslesen"
Write-Host "2. Postfachkalenderberechtigung hinzufügen"
Write-Host "`n"
$condition2 = Read-Host "Bitte geben Sie einer der oben genannten Zahlen an"
Write-Host "`n"

switch($condition2){



1
{

$username = Read-Host "Bitte geben Sie den Username ein! (mit Domäne)"
Write-Host = "`n"



$username = $username + ":\Kalender"
Get-MailboxfolderPermission $username
}



2
{
$username = Read-Host "Bitte geben Sie den Username bei dem Sie eine Berechtigung hinzufügen möchten! (mit Domäne)"



Write-Host -NoNewline "Bitte geben Sie den Username an dem Sie Berechtigungen auf den Kalender von "
Write-Host -NoNewline -ForegroundColor Yellow $username
$accessusername = Read-Host " geben möchten! (mit Domäne)"
Write-Host "`n"


Write-Host "------------------------------------------"
Write-Host "`n"
Write-Host "Sie haben die Auswahl zwischen folgenden Berechtigungen: Reviewer (ansehen), Editor (bearbeiten), Owner (Vollzugriff)"
Write-Host "`n"
Write-Host "------------------------------------------"


Write-Host -NoNewline "Bitte geben Sie die Berechtigung an, die Sie dem dem User "
Write-Host -NoNewline -ForegroundColor Yellow $accessusername
$calenderright = Read-Host " geben möchten!"

$username = $username + ":\Kalender"
Write-Host "`n"



Add-MailboxFolderPermission -Identity $username -user $accessusername -AccessRights $calenderright



Write-Host "------------------------------------------"
Write-Host -ForegroundColor Yellow "Berechtigung wurde besetzt!"
Write-Host "------------------------------------------"
Write-Host = "`n"
$condition3 = Read-Host "Möchten Sie die Berechtigungen nochmal prüfen (J/N)"


if($condition3 -eq 'J' -or $condition3 -eq 'j')
{
Write-Host -ForegroundColor Yellow "Hier die Berechtigungsauflistung: "
Get-MailboxfolderPermission $username
}

}




}

Write-Host = "`n"
$condition1 = Read-Host "Möchten Sie weitere Berechtigungen auslesen/hinzufügen? (J/N)"


}