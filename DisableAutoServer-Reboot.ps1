function DisableAutoServerReboot{
#Documentation: https://it-learner.de/die-aufgabeplanung-mit-der-windows-powershell-verwalten/
#Documentation: https://www.mioso.com/blog/microsoft-windows/windows-server/automatischer-neustart-nach-updates-deaktivieren-windows-server-2016/
    Write-Host -ForegroundColor Cyan "Die Aufgabe fuer den automatischen Reboot wird deaktiviert..."
    Get-ScheduledTask -TaskPath \Microsoft\Windows\UpdateOrchestrator* -TaskName Reboot | Disable-ScheduledTask
    $LocalHostname = $env:computername
    $TaskFolder = "C:\Windows\System32\Tasks\Microsoft\Windows\UpdateOrchestrator\Reboot"
    $NewFileName = "Reboot.bak"
    Rename-Item -Path $TaskFolder -NewName $NewFileName
    Write-Host -ForegroundColor Green "Der automatische Server-Reboot wurde fuer $LocalHostname deaktiviert!"

}

DisableAutoServerReboot