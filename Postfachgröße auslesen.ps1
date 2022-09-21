Install-Module ExchangeOnlineManagement
Import-Module ExchangeOnlineManagement

Connect-ExchangeOnline

function ReadMailboxSize(){
    [Cmdletbinding()]
    param(
            [Parameter(ValueFromPipeline)]
            [string]$user
    )

Get-EXOMailboxStatistics -Identity $user | Select-Object DisplayName, TotalItemsize
}

Write-Host -NoNewline "Befehl um die Größe eines Postfachs auszulesen: "
Write-Host -ForegroundColor Green '"postfach@domain.xy | ReadMailboxSize" '