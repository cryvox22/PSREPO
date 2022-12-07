function GetIPAddress{

    Write-Host -ForegroundColor Green "Ihre IP-Adresse wird ausgelesen..."
    Get-NetIPAddress | Where-Object  {$_.AddressFamily -eq "IPv4" -and $_.InterfaceAlias -clike "Ethernet*"} | Select-Object InterfaceAlias, IPAddress
        
      
}



function SetIPAddress {

    Write-Host -ForegroundColor Green -NoNewline "Moechten Sie die IP-Adresse des Netzwerkadapters aendern? (Y/N)"
    $Input1 = Read-Host
    if($Input1 -eq "y" -or $Input1 -eq "Y"){

    Write-Host -ForegroundColor Green -NoNewline "Bitte geben Sie den Interface Alias des zu aendernden Adapters ein"
    $InputAdapterAlias = Read-Host
    Write-Host -ForegroundColor Green -NoNewline "Bitte geben Sie die gewünschte IP-Adresse für den $InputAdapterAlias ein (z.B. 192.168.0.10)"
    $InputIPAddress = Read-Host


    $IntefaceIndex = Get-NetIPAddress -InterfaceAlias $InputAdapterAlias | Select-Object InterfaceIndex
    Set-NetIPAddress -InterfaceIndex $IntefaceIndex -IPAddress $InputIPAddress -PrefixLength 24
    Write-Host -ForegroundColor Green "Ihre IP Adresse wurde für Netzwerkadapter $InputAdapterAlias auf $inputIPAddress gesetzt!"
    }
}


function SetIPAddressDHCP{
    Write-Host -ForegroundColor Green -NoNewline "Moechten Sie den Netzwerkadapter $InputAdapterAlias wieder auf DHCP umstellen? (Y/N)"
    $Input2 = Read-Host
    if($Input2 -eq "y" -or $Input2 -eq "Y"){
        Set-NetIPInterface -InterfaceIndex $IntefaceIndex  -Dhcp Enabled
        Write-Host -ForegroundColor Green "Der Netzwerkadapter wurde auf DHCP umgestellt!"
    }
    else {
        <# Action when all if and elseif conditions are false #>
    }
}

GetIPAddress
SetIPAddress
SetIPAddressDHCP