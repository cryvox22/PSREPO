Function Get-LoggedOnUsers {
    $computername = $env:COMPUTERNAME
    Get-WmiObject -Class Win32_LogonSession -ComputerName $computername |
    ForEach-Object {
        $LogonId = $_.__RELPATH -replace """", "'"
        $usernames = Get-WmiObject -ComputerName $computername -Query "ASSOCIATORS OF {$LogonId} WHERE ResultClass = Win32_Account" | Select-Object "Caption"
        $usernames

        
    }
}
Write-Host ""
Write-Host -ForegroundColor Green "Nachfolgend alle angemeldeten User: "
Write-Host ""
Get-LoggedOnUsers