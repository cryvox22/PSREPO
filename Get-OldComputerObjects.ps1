
function Get-OldComputerObjects{
Get-ADComputer -Filter * -Properties operatingsystem,lastlogondate | Where-Object {($_.operatingsystem -notlike "*Server*") -and ($_.lastlogondate -le ((Get-Date).adddays(-365)))} | Sort-Object Lastlogondate | Format-Table Name,Lastlogondate
}

function Get-ADModule {
    Install-Module -Name Active-Directory
    Import-Module -Name Active-Directory
}

Write-Host -ForegroundColor Green "Willkommen bei Get-OldComputerObjects!"

Write-Host ""

Write-Host -ForegroundColor Cyan "Nachfolgend werden alle verwaisten Computerkonten im Active-Directory aufgelistet:"
Write-Host ""

Get-ADModule

Get-OldComputerObjects