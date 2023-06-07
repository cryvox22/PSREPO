
Write-host "halle" -ForegroundColor Green
Write-host "halle" -ForegroundColor Green
Write-host "halle" -ForegroundColor Green
Write-host "halle" -ForegroundColor Green
Write-host "halle" -ForegroundColor Green
Write-host "asdfasfadfssd" -ForegroundColor Green



Get-ChildItem -Path C:\Windows\Panther -Recurse | Select-String 'first boot' | Select-Object -Last 1

Set-Location $home\Downloads
1..10 | ForEach-Object {New-Item -ItemType File -Name file$_.txt}


Get-Volume -DriveLetter C

Test-Connection -TargetName 192.168.178.1 -IPv4 -Repeat


powershell -ExecutionPolicy Bypass -File C:\Temp\script.1


Unblock-File C:\temp\Check-FreeDiskSpace.ps1

Get-ExecutionPolicy -List