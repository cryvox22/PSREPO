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