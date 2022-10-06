Write-Host -ForegroundColor Green "WinRM-Aktivierung wird gestartet..."

Enable-PSRemoting
winrm quickconfig -force

Write-Host -ForegroundColor Green "WinRM-Aktivierung ist abgeschlossen!"