function EnableWinrm{
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]
    $Servername,

    [Parameter(Mandatory = $false, Position = 1)]
    [Switch]
    $NonDomain
)
    Enable-PSRemoting -Force
    winrm quickconfig

    if($NonDomain){
        Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value $Servername -Force    
        Get-Item WSMAN:\Localhost\Client\TrustedHosts 
    }
    


}