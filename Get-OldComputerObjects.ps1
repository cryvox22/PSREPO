#Documentation: https://adamtheautomator.com/powershell-import-active-directory/



function Get-OldComputerObjects{
Get-ADComputer -Filter * -Properties operatingsystem,lastlogondate | Where-Object {($_.operatingsystem -notlike "*Server*") -and ($_.lastlogondate -le ((Get-Date).adddays(-365)))} | Sort-Object Lastlogondate | Format-Table Name,Lastlogondate
}

function Get-ADModuleClient {
    Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
   
}

function Get-ADModuleServer{

    Import-Module ServerManager
    Install-WindowsFeature -Name RSAT-AD-PowerShell
}

Write-Host -ForegroundColor Green "Willkommen bei Get-OldComputerObjects!"

Write-Host ""

Write-Host -NoNewline -ForegroundColor Green "Greifen Sie via. Client oder Server zu (C/S)?"
$x = Read-Host


if($x -eq "c" -or $x -eq "C"){

    Get-ADModuleClient
    Clear-Host
}
elseif($x -eq "s" -or $x -eq "S"){

Get-ADModuleServer
    Clear-Host  
}


Write-Host -ForegroundColor Cyan "Nachfolgend werden alle verwaisten Computerkonten im Active-Directory aufgelistet:"
Write-Host ""



Get-OldComputerObjects