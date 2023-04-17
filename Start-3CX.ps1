write-host "`n"
Write-Host -ForegroundColor Green "Willkommen beim Start-3CX!"
Write-Host "------------------------------------"
write-host "`n"
Write-Host -ForegroundColor Cyan  "3CX-Dienste werden gestartet...!"


function start3CX{
    Start-Service -Name *3cx*
    Get-Service -Name *3cx* | Select-Object Name, Status  
}

Write-Host -ForegroundColor Cyan  "3CX-Dienste wurden gestartet...!"
Write-Host -ForegroundColor Red -NoNewline "Bitte eine beliebige Taste druecken um zu beenden..."
Read-Host