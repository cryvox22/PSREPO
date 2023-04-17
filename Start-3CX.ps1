


function start3CX{
    write-host "`n"
    Write-Host -ForegroundColor Green "Willkommen beim Start-3CX!"
    Write-Host "------------------------------------"
    write-host "`n"
    Write-Host -ForegroundColor Cyan  "3CX-Dienste werden gestartet...!"
    Start-Service -Name *3cx* | Where-Object{$_.StartType -eq "Automatic"}
    
    Write-Host -ForegroundColor Cyan  "3CX-Dienste wurden gestartet...!"
    Get-Service -Name *3cx* | Where-Object{$_.StartType -eq "Automatic"} | Select-Object Name, Status  
    
    Write-Host -ForegroundColor Red -NoNewline "Bitte eine beliebige Taste druecken um zu beenden..."
    Read-Host
    }
    
    start3CX
    