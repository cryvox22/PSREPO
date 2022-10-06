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

function DisableSMB1{
    #Prüfung ob SMB1 aktiv ist
    Write-Host -ForegroundColor Cyan "SMB1 Pruefung wird durchgefuehrt..."

    $Smb1State = (Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol).state

    if($Smb1State -eq "Disabled"){
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
    #Prüfung ob ExecutionPolicy auf "Bypass" gesetzt ist
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


function JoinADDomain{
    #DomainJoin
    [CmdletBinding()]
Param(
   $DomName = @( "contoso.local")
)
 
Begin 
{
    Write-Host -ForegroundColor Cyan "Domainanmeldung wird gestartet..."   
}
 
Process 
{
    Write-Host -NoNewline -ForegroundColor Green "Moechten Sie diesen Computer zu einer Domain hinzufuegen (J/N)"
    $UserInput1 = Read-Host
    if($UserInput1 -eq "j" -or $UserInput1 -eq "J"){
        $ComputerHostName = $env:COMPUTERNAME
        Write-Host -NoNewline -ForegroundColor Green "Moechten Sie dem Computer einen neuen Hostnamen geben (J/N)"
        $UserInput2 = Read-Host
        if($UserInput2 -eq "j" -or $UserInput2 -eq "J"){
            Write-Host -NoNewline -ForegroundColor Green "Bitte geben Sie den neuen Hostname ein: "
            $ComputerHostName = Read-Host
            Write-Host -NoNewline -ForegroundColor Green "Bitte geben Sie Ihre Zugangsdaten ein:"
            $DomainCredentials = Get-Credential
            Write-Host""
            Write-Host -ForegroundColor Cyan "Der Computer " $ComputerHostName "wird der Domain " $DomName "hinzugefuegt..."
            Add-Computer -ComputerName $ComputerHostName -DomainName $DomName -Credential $DomainCredentials -Restart -Force
        }
        else {
            Write-Host -NoNewline -ForegroundColor Green "Bitte geben Sie Ihre Zugangsdaten ein:"
            $DomainCredentials = Get-Credential
            Write-Host""
            Write-Host -ForegroundColor Cyan "Der Computer " $ComputerHostName "wird der Domain " $DomName "hinzugefuegt..."
            Add-Computer -ComputerName $ComputerHostName -DomainName $DomName -Credential $DomainCredentials -Restart -Force
        }
    }   
    else{
        Write-Host -NoNewline -ForegroundColor Green "Domainanmeldung wird beendet..."
    }
}
 
}


#Funktionsaufruf
SetExecutionPolicy
EnableWinRM
DisableSMB1
JoinADDomain


