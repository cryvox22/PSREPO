# Variablen 


$Hostname = [System.Net.DNS]::GetHostByName('').HostName
$HostnamePure = $env:COMPUTERNAME
$cimSession = New-CimSession -ComputerName $HostnamePure
$IpAddress = (Get-CimInstance -CimSession $cimSession -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'").IPAddress[0]
$MacAddress = (Get-CimInstance -CimSession $cimSession -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'").MACAddress
$Subnetmask = (Get-CimInstance -CimSession $cimSession -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'").IPSubnet
$Gateway = (Get-CimInstance -CimSession $cimSession -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'").DefaultIPGateway
$DnsServer = (Get-CimInstance -CimSession $cimSession -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'").DNSServerSearchOrder
$DhcpServer = (Get-CimInstance -CimSession $cimSession -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'").DNSServerSearchOrder 
$DhcpStatus = (Get-CimInstance -CimSession $cimSession -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'").DHCPEnabled
if($DhcpStatus -eq "True")
{
    $DhcpStatus = "JA"
}
else{
    $DhcpStatus = "Nein"
}

# Funktionen
function pingsmth1 {
   
    Write-Host ""
    Write-Host -NoNewline -ForegroundColor Green "Moechtest du noch einen Ping und Nslookup ausfuehren? (J/N): "
    $Dywd1 = Read-Host

    if (($Dywd1 -eq "J") -or ($Dywd1 -eq "j"))  {

    Write-Host -NoNewline -ForegroundColor Yellow "Bitte geben Sie eine IP ein, die gepingt werden soll: " 
    $PingTargetIp = Read-Host 

    Write-Host -NoNewline -ForegroundColor Yellow "Bitte geben Sie einen Hostnamen ein, der gepingt werden soll: "
    $PingTargetHostname = Read-Host 

    Write-Host ""
    Write-Host -ForegroundColor Cyan "Nachfolgend NSLOOKUP mit Hostname und IP:"
    nslookup.exe $PingTargetHostname
    nslookup.exe $PingTargetIp

    Write-Host -ForegroundColor Cyan "Nachfolgend Ping-Tests mit Hostname und IP:"
    Test-Connection $PingTargetHostname
    Test-Connection $PingTargetIp
    }else 
    {
        Write-Host -ForegroundColor Cyan "Danke für deine Nutzung!"
    }
}
   


<#
Was soll passieren?

- saubere Auflistung von IP, Hostname, Gateway, DNS, DHCP-Status, DHCP-Server, kurzer Ping an IP und Hostname, NSlookup

#> 


#Ausführung

Write-Host -NoNewline "Netzwerkuebersicht fuer: " 
Write-Host -ForegroundColor Green $HostnamePure
Write-Host -ForegroundColor Green "------------------------------------------------------------------"

Write-Host -NoNewline "Hostname: "
Write-Host -ForegroundColor Green $Hostname
Write-Host -NoNewline "IP: "
Write-Host -ForegroundColor Green $IpAddress
Write-Host -NoNewline "MAC-Addresse: "
Write-Host -ForegroundColor Green $MacAddress
Write-Host -NoNewline "Subnetzmaske: "
Write-Host -ForegroundColor Green $Subnetmask.split(' ')[0] "/"  $Subnetmask.split(' ')[1]
Write-Host -NoNewline "Gateway: "
Write-Host -ForegroundColor Green $Gateway
Write-Host -NoNewline "DNS-Server: "
Write-Host -ForegroundColor Green $DnsServer
Write-Host -NoNewline "DHCP aktiv: "
Write-Host -ForegroundColor Green $DhcpStatus
Write-Host -NoNewline "DHCP Server: "
Write-Host -ForegroundColor Green $DhcpServer

pingsmth1






    



   

