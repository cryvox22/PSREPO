#Variablen einlesen



Write-Host -NoNewline "Bitte Geben Sie den Computernamen des Gerätes ein, auf das Sie sich verbinden möchten!"
$Computername = Read-Host


Write-Host -NoNewline "Bitte Geben Sie die entsprechenden Zugangsdaten ein!"
$cred = Get-Credential



Write-Host -ForegroundColor Yellow "Die Verbindung zu " + $Computername + " wird jetzt aufgebaut...!"
Enter-PSSession -ComputerName $Computername -Credential $cred