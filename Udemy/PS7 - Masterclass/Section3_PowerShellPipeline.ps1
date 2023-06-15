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