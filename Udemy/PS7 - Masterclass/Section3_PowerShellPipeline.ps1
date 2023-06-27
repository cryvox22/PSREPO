Write-Host "Hier geht es um Pipelines!" -ForegroundColor Green


#Get-Process notepad mspaint | Stop-Process

#Get-SmbOpenFile | Close-SmbOpenFile

#New-Item -ItemType File -Path .\usernames.txt

Add-Content -Path .\usernames.txt -Value "Patrick", "Gentner", "Rudolf", "Gentner", "Birgit", "Gentner", "Birgit", "Gentner"

#Get-Content -Path .\usernames.txt
#(Get-Content -Path .\usernames.txt)[0..2]

Get-Content -Path .\usernames.txt | Sort-Object | Get-Unique | Add-Content -Path .\usernames_unique.txt
Get-Content -Path .\usernames_unique.txt

Get-Content -Path .\usernames_unique.txt | Measure-Object
(Get-Content -Path .\usernames_unique.txt).count

Compare-Object -ReferenceObject (Get-Content -Path .\usernames.txt) -DifferenceObject (Get-Content -Path .\usernames_unique.txt)



Get-Process | Where-Object { $_.CPU -gt 10 } | Select-Object Name, CPU, Handles -First 10 | Sort-Object ProcessName -Descending | Format-Table -Wrap -AutoSize
#Rufe alle Prozesse auf, aber nur die, bei denen die CPU-Zeit größer als 10 Sekunden ist, sortiere diese nach Prozessnamen und formatiere die tabelle, zeige nur die ersten 10 an



1..3 | ForEach-Object { $_ }

Get-Process | Get-Member

Get-Process | Where-Object { $_.CPU -gt 10 -and $_.Handles -gt 1000 } | Sort-Object ProcessName -Descending | Format-Table -Wrap -AutoSize | Select-Object -First 10

Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online

Get-ADComputer -Properties * -Filter 'operatingsystem -like "windows 8"' | Set-ADComputer -Enabled $false


Measure-Command { Get-ADComputer -Properties * -Filter 'operatingsystem -like "windows 8"' | Set-ADComputer -Enabled $false }

Get-HotFix | Where-Object InstalledOn -ge (get-date).AddDays(-50)

$meinOneDrivePrivat = $env:OneDriveConsumer
$meinOneDriveFirma = $env:OneDriveCommercial


$OneDrive = $env:OneDriveConsumer + '\Dokumente\Privat\09_Learning\Powershell\Udemy - Powershell7-Masterkurs\'
Import-Csv $OneDrive\sample_manufacturer.csv, $OneDrive\sample_manufacturer_2.csv | Where-Object { $_.Manufacturer -eq 'Microsoft' -and $_.BiosVersion -like '13.*' -and $_.CanUpdate -eq 'true' } | Export-Csv $OneDrive\microsoft_13_canupdate.csv -NoTypeInformation
Import-Csv 'C:\Users\p.gentner\OneDrive\Dokumente\Privat\09_Learning\Powershell\Udemy - Powershell7-Masterkurs\microsoft_13_canupdate.csv'




#Klammern und Co
(Get-Date).AddYears(-100) 
#Code in runden Klammmern () wird sofort ausgefürt (also noch vor der kompletten Zeile)

Get-Random -InputObject (1..45) -Count 6
#Random-Numbers generieren

If (Get-ChildItem C:\gibtesnicht -ErrorAction SilentlyContinue){
    Write-Output 'Ordner da.'
}
else{
    Write-Output 'Ordner nicht da.'
}
#Geschwungene Klammern werden dann ausgeführt, wenn sie an der Reihe sind (Skriptblöcke)


#Spezialklammern und Anwendungen
Get-Process [teams]*
#Eckige Klammern sind für spezielle Zwecke zu verwenden (z.B. Arrays)

$mail = "patrickgentner27@gmail.com"
$split = $mail.Split('@')
$split[0]
#Auch in Powershell haben wir einen 0-basierten-Index

Get-Process [a]*

Get-Process [r-s]*

$array = [array]('Peter','Margit')
$array[0]

[char[]](65..90)





#Sort-Object // Select-Object

Get-Process | Sort-Object CPU -Descending
#Sortiert absteigend

Get-Process | Select-Object CPU, Id, ProcessName
#Wählt nur bestimmte Werte aus, die ausgegeen werden, verändert allerdings das Objekt nicht, sodass damit weitergearbeitet werden kann

Get-Process | Select-Object CPU, Id, ProcessName -Last 3
#Mit Parameter kann angepasst werden 


Get-Process | Sort-Object CPU -Descending | Select-Object ProcessName, CPU -First 3
#kann gemischt werden


Get-Process | Get-Member
Get-Process | Select-Object -Property *


#Select-Object -ExpandProperty oder ().x: 

$comp = Get-ADComputer -Filter * | Select-Object -Property Name
Test-Connection -ComputerName $comp
#Powershell versucht nicht die Names zu pingen sondern @{name=hostname} 


#Die Lösung hier ist -ExpandProperty!
$comp = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name
Test-Connection -ComputerName $comp

#Alternative ist der Punkt
$comp = (Get-ADComputer -Filter *).Name
Test-Connection $comp


#weiteres Beispiel
$boot1 = Get-ComputerInfo | Select-Object OsLastBootUpTime
$boot2 = Get-ComputerInfo | Select-Object -ExpandProperty OsLastBootUpTime
$boot3 = (Get-ComputerInfo).OsLastBootUpTime
(Get-Date) -$boot3




#Custom Properties

Get-CimInstance -Class Win32_PhysicalMemory | Select-Object Manufacturer, BankLabel, ConfiguredClockSpeed, SerialNumber, @{n="RAM"; e={[Math]::Round($_.Capacity/1GB)}} | Format-Table


#Select-String
'Hello', 'HELLO' | Select-String -Pattern 'HELLO' -CaseSensitive

$Eventlogs = Get-WinEvent -LogName Application -MaxEvents 50 | Select-String -InputObject {$_.message} -Pattern 'Fehler'
Write-Output $Eventlogs

Select-String -Path C:\Windows\Panther\setupact.log -Pattern 'First Boot'


#Limitierung der Pipe
Get-ChildItem -Path C:\Temp\ -Directory | ForEach-Object {New-SmbShare -Name $_.Name -Path $_.FullName -FullAccess Everyone -Description Test}


#Abschluss-Aufgabe Modul: 

Get-ComputerInfo | Get-Member
