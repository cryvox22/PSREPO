function EnableWinRM {
    #Prüfung ob WinRM aktiv ist
    Write-Host -ForegroundColor Cyan "WinRM Pruefung wird durchgefuehrt..."
    $WinrmStatus = (Get-Service WinRM).Status
    if($WinrmStatus -eq "Running"){
        Write-Host -ForegroundColor Green "WinRM ist bereits aktiviert!"
    }
    else{
    Write-Host -ForegroundColor Green "WinRM-Aktivierung wird gestartet..."
    Enable-PSRemoting
    winrm quickconfig -force
    Write-Host -ForegroundColor Green "WinRM-Aktivierung ist abgeschlossen!"
    }
    Write-Host -ForegroundColor Cyan "WinRM Pruefung ist abgeschlossen!"
}
EnableWinRM