<#

Eigene Read- und Write-Function schreiben, die in den Untermodulen verwendet werden kann



ToDo's für die Untermodule: 

SL-Doc: 
- alle Teilbereiche in eigene Functions auslagern
- Ausgabe und Zusammenfassung verbessern
- Systemspecs mit auslesen
- Get-Mac anpassen
- einzelne Teilinformationen via. Befehl abrufbar machen (z.B. SL-Doc -Value "Serial" -> gibt Seriennummer aus und schiebt sie ins Clipboard)


Allgemein: 
- Cmdlet für Read und Write-Host erstellen
- Cmdlet für Export erstellen


#>

function Ausgabe {
    [CmdletBinding()]
    param(

        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        $Text,


        # Farbe
        [Parameter(Position = 1, Mandatory = $false)]
        [ValidateSet('Green', 'Red', 'Cyan', 'Yellow', 'White', 'Blue', 'Magenta')]
        [String]
        $Farbe = "White",

        [Parameter(Position = 2, Mandatory = $false)]
        [switch]
        $NoNewLine
    )

 
        
    if ($NoNewLine) {
        Write-Host -Object $Text -ForegroundColor $Farbe -NoNewline
    }
    else {
        Write-Host -Object $Text -ForegroundColor $Farbe
    }
    

}

function Eingabe {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        $Text
    )
    Ausgabe -Text $Text": " -Farbe Green -NoNewLine
    $InputVar = Read-Host
    return $InputVar
}

function ModuleStarted {
    Clear-Host
    Ausgabe "---------------------------------" Red
    Ausgabe "-----Willkommen zur SLShell!-----" Red
    Ausgabe "---------------------------------" Red
    Ausgabe " "
    Ausgabe "WICHTIG: Jede Funktion wird mit dem Praefix 'SL-' aufgerufen" Green
    Ausgabe "-----------------------------------------------------------" Green
    Ausgabe "SL-Doc" Cyan -NoNewLine
    Ausgabe " - Gathert alle wichtigen Informationen zur Dokumentation in IT-Glue" Green
    Ausgabe "SL-Cleanup" Cyan -NoNewLine 
    Ausgabe " - Bereinigt PCs und Server" Green
    Ausgabe "SL-Install" Cyan -NoNewLine
    Ausgabe " - Installiert verschiedene Anwendungen" Green
    Ausgabe "SL-Remove" Cyan -NoNewLine
    Ausgabe " - Deinstalliert verschiedene Anwendungen, Features etc." Green
    Ausgabe "SL-Netdoc" Cyan -NoNewLine
    Ausgabe " - Tolls fuer Basic NetzwerkTroubleshooting" Green
    Ausgabe "SL-Connect" Cyan -NoNewLine 
    Ausgabe " - Baut Verbindungen zu verschiedenen CloudShells auf (M365, AzureAD, ExOnline, Servereye, Datto etc.)" Green
    Ausgabe "SL-Standard" Cyan -NoNewLine
    Ausgabe " - Setzt Basic Settings fuer Clients und Server" Green
    Ausgabe "SL-SQL" Cyan -NoNewLine
    Ausgabe " - Hilft bei der Informationsbeschaffung im SQL-Server" Green
    Ausgabe "SL-Deploy" Cyan -NoNewLine
    Ausgabe " - Deployed verschiedene Services und Features VMs, DCs usw." Green
}

function Doc{


    function Get-Hostname{
        $hostname = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
        $hostname | Set-Clipboard
        return $hostname
    }

    function Get-Serial{
        $serial = (Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber
        $serial | Set-Clipboard
        return $serial
    }
    
    function Get-Model{
        $model = (Get-CimInstance CIM_ComputerSystem).Model 
        $model | Set-Clipboard
        return $model
    }

    function Get-InstallDate{
        $installdate = (Get-WmiObject Win32_OperatingSystem).ConvertToDateTime( (Get-WmiObject Win32_OperatingSystem).InstallDate) 
        $installdate | Set-Clipboard
        return $installdate
    }

    function Get-IpAddress{
        $ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).ipaddress
        $ip | Set-Clipboard
        return $ip
    }

    function Get-MacAddress{
        $mac = Get-NetAdapter | Where-Object LinkSpeed -match "1* Gbps" | Where-Object Status -eq "Up" | Select-Object -ExpandProperty "MacAddress"
        $mac | Set-Clipboard
        return $mac
    }

    function Get-Gateway{
        $gateway = Get-NetRoute -DestinationPrefix "0.0.0.0/0" | Select-Object -ExpandProperty "NextHop"
        $gateway | Set-Clipboard
        return $gateway
    }

    function Get-OS{
        $os = (Get-WMIObject win32_operatingsystem).caption
        $os | Set-Clipboard
        return $os
    }
    
    function Get-WindowsKey{
        $WindowsKey = (Get-WmiObject SoftwareLicensingService).OA3xOriginalProductKey
        $WindowsKey | Set-Clipboard
        return $WindowsKey
    }

    function Get-DocSummary{
        Ausgabe "-------------------------------------------" Green
        Ausgabe "Hostname: " -NoNewLine
        Ausgabe  (Get-Hostname) Yellow 
        Ausgabe "Seriennummer: " -NoNewLine
        Ausgabe (get-serial) Yellow
        Ausgabe "Modell: " -NoNewLine
        Ausgabe (get-model) Yellow
        Ausgabe "IP-Adresse: " -NoNewLine
        Ausgabe (get-ipaddress) Yellow
        Ausgabe "Mac-Adresse: " -NoNewLine
        Ausgabe (get-MacAddress) Yellow
        Ausgabe "Gateway: " -NoNewLine
        Ausgabe (Get-gateway) -Yellow
        Ausgabe "Betriebssystem: " -NoNewLine
        Ausgabe (get-OS) Yellow
        Ausgabe "Windows-Key: " -NoNewLine
        Ausgabe (get-WindowsKey) Yellow
        Ausgabe "-------------------------------------------" Green
    }

}

function Cleanup{

}

function Install {

    Write-Host -ForegroundColor Green "Waehle die zu installierende Software aus!"


}

function Remove {
    Write-Host  -ForegroundColor Green "Waehle die zu deinstallierende Software aus!"

    function RemoveServerEye {

    }
}

function Netdoc {
    Write-Host -ForegroundColor Green "Waehle dein Netdoc-Tool aus!"
}

function Connect {
    Write-Host -ForegroundColor Green "Wohin moechtest du dich connecten?"
}

function Standard {
    Write-Host -ForegroundColor Green "Welche Standards willst du ausrollen?!"
}

function SQL {
    Write-Host -ForegroundColor Green "Welche SQL-Daten brauchst du?"
}

function Deploy {
    Write-Host -ForegroundColor Green "Was willst du deployen?"
}

ModuleStarted



