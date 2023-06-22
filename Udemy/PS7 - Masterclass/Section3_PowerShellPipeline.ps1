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