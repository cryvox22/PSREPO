function EnableWinRM {
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

function DisableSMB1{
    #Prüfung ob SMB1 aktiv ist
    Write-Host -ForegroundColor Cyan "SMB1 Pruefung wird durchgefuehrt..."

    $Smb1State = (Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol).state

    if($Smb1State -eq "false"){
        Write-Host -ForegroundColor Green "SMB1 ist bereits deaktiviert!"
    }
    else{
        Write-Host -ForegroundColor Green "SMB1 wird deaktiviert..."
        Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
        Write-Host -ForegroundColor Green "SMB1 ist deaktiviert!"
    }
    Write-Host -ForegroundColor Cyan "SMB1 Pruefung ist abgeschlossen!"
}

function SetExecutionPolicy{
    Write-Host -ForegroundColor Cyan "ExecutionPolicy Pruefung wird durchgefuehrt!"
    $ExecutionPolicyStatus = Get-ExecutionPolicy
    if($ExecutionPolicyStatus -eq "Bypass"){
        Write-Host -ForegroundColor Green "Die ExecutionPolicy ist bereits auf 'Bypass' gesetzt!"
    }
    else{
        Write-Host -ForegroundColor Green "ExecutionPolicy wird angepasst..."
        Set-ExecutionPolicy Bypass -Force
        Write-Host -ForegroundColor Green "Die ExecutionPlicy wurde auf 'Bypass' gesetzt!"
    }
    Write-Host -ForegroundColor Cyan "ExecutionPolicy Pruefung ist abgeschlossen!"
}


SetExecutionPolicy
EnableWinRM
DisableSMB1


