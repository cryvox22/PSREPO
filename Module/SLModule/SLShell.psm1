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





function ModuleStarted{
    Clear-Host
    Write-Host -ForegroundColor Cyan "-----Willkommen zur SLShell!-----"
    Write-Host ""
    Write-Host -ForegroundColor Green "WICHTIG: Jede Funktion wird mit dem Praefix 'SL-' aufgerufen"
    Write-Host -ForegroundColor Green "-----------------------------------------------------------"
    Write-Host -ForegroundColor Green "SL-Doc - Gathert alle wichtigen Informationen zur Dokumentation in IT-Glue"
    Write-Host -ForegroundColor Green "SL-Cleanup - Bereinigt PCs und Server"
    Write-Host -ForegroundColor Green "SL-Install - Installiert verschiedene Anwendungen"
    Write-Host -ForegroundColor Green "SL-Remove - Deinstalliert verschiedene Anwendungen, Features etc."
    Write-Host -ForegroundColor Green "SL-Netdoc - Tools zum Basic NetworkTroubleshooting"
    Write-Host -ForegroundColor Green "SL-Connect - Baut Verbindungen zu verschiedenen CloudShells auf (M365, AzureAD, EXOnline, ServerEye)"
    Write-Host -ForegroundColor Green "SL-Standard - Setzt Basic Settings fuer Clients und Server"
    Write-Host -ForegroundColor Green "SL-SQL - Hilft bei der Informationsbeschaffung im SQL-Server"
    Write-Host -ForegroundColor Green "SL-Deploy - Deployed verschiedene Services und Features VMs, DCs usw"
}


#Start SL-Doc
function Doc{
#----------------------

#Hostname

function Get-Hostname{
    Write-Host "-------------------------------------------"
    Write-Host "Hostnamen: "
    Write-Host "-------------------------------------------"
    $hostname = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
    $hostname | clip
    Write-Host -NoNewline "Der Hostname "
    Write-Host -NoNewline -ForegroundColor Yellow $hostname
    Write-Host " befindet sich jetzt in der Zwischenablage!"
    Write-Host "`n"
    pause
}
#----------------------


#----------------------
#Seriennummer
function Get-Serial{
    Write-Host "-------------------------------------------"
    Write-Host "Seriennummer: "
    Write-Host "-------------------------------------------"
    $serial = (Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber
    $serial | clip
    Write-Host -NoNewline "Die Seriennummer " 
    Write-Host -NoNewline -ForegroundColor Yellow $serial
    Write-Host " befindet sich jetzt in Ihrer Zwischenablage!"
    write-host "`n"
    pause
}
#----------------------



#----------------------
#Modell
function Get-Modell{
    Write-Host "-------------------------------------------"
    Write-Host "Modell: "
    Write-Host "-------------------------------------------"
    $system = Get-CimInstance CIM_ComputerSystem
    $Modell = $system.Model
    $Modell | clip
    Write-Host -NoNewline "Das Modell:  " 
    Write-Host -NoNewline -ForegroundColor Yellow $Modell
    Write-Host " befindet sich jetzt in Ihrer Zwischenablage!"
    write-host "`n"
    pause
}
#----------------------


#----------------------
#Installiert am: 
function Get-InstallDate{
    Write-Host "-------------------------------------------"
    Write-Host "Installiert am: "
    Write-Host "-------------------------------------------"
    Write-Host -NoNewline "Das Device " $hostname " wurde am folgenden Tag installiert: "   
    $installdate = (Get-WmiObject Win32_OperatingSystem).ConvertToDateTime( (Get-WmiObject Win32_OperatingSystem).InstallDate ) 
    Write-Host -NoNewline -ForegroundColor Yellow $installdate
    $installdate | clip
    Write-Host "Das Installationsdatum befindet sich jetzt in der Zwischenablage!"
    write-host "`n"
    pause
}
#----------------------


#----------------------
#IP-Addresse
function Get-IPAddress{
    Write-Host "-------------------------------------------"
    Write-Host "IP-Addresse: "
    Write-Host "-------------------------------------------"
    $ip =  (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).ipaddress
    $ip | clip
    Write-Host -NoNewline "Die IP-Addresse " 
    Write-Host -NoNewline -ForegroundColor Yellow $ip 
    Write-Host " befindet sich jetzt in Ihrer Zwischenablage!"
    Write-Host "`n"
    pause
}
#----------------------




#----------------------
#Mac-Addresse
function Get-MacAddress{
    Write-Host "-------------------------------------------"
    Write-Host "Mac-Addresse: "
    Write-Host "-------------------------------------------"

    Get-NetAdapter | Sort-Object Name -Descending | Select-Object Name, InterfaceDescription, MacAddress | Write-Output
    
    

        $EthAdapterNumber = Read-Host "Suche einen Adapter aus (1,2,3..)"
        Write-host "`n"
        $intEthAdapterNumber = [int]$EthAdapterNumber
        $intEthAdapterNumber = $intEthAdapterNumber-1
        $AdapterName = "Ethernet" +$intEthAdapterNumber
        if($intEthAdapterNumber-eq 0)
        {
        $mac =  (Get-NetAdapter -Name Ethernet).macaddress
        $mac | clip
        }
        else
        {
        $mac =  (Get-NetAdapter -Name Ethernet + $intEthAdapterNumber).macaddress
        $mac | clip
        }
    
    
    

    Write-Host -NoNewline "Die Mac-Addresse " 
    Write-Host -NoNewline -ForegroundColor Yellow $mac
    Write-Host " befindet sich jetzt in Ihrer Zwischenablage!"
    write-host "`n"
    pause
}
#----------------------



#----------------------
#Gateway
function Get-Gateway{
    Write-Host "-------------------------------------------"
    Write-Host "Gateway: "
    Write-Host "-------------------------------------------"
    $gateway = Get-NetRoute -DestinationPrefix "0.0.0.0/0" | Select-Object -ExpandProperty "NextHop"
    $gateway | clip
    Write-Host -NoNewline "Das Gateway  " 
    Write-Host -NoNewline -ForegroundColor Yellow $gateway 
    Write-Host " befindet sich jetzt in Ihrer Zwischenablage!"
    write-host "`n"
    pause
}
#----------------------


#----------------------
#OS
function Get-OS{
    Write-Host "-------------------------------------------"
    Write-Host "Betriebssystem: "
    Write-Host "-------------------------------------------"
    $os = (Get-WMIObject win32_operatingsystem).caption
    $os | clip
    Write-Host -NoNewline "Die Betriebssystemversion " 
    Write-Host -NoNewline -ForegroundColor Yellow $os 
    Write-Host " befindet sich jetzt in Ihrer Zwischenablage!"
    write-host "`n"
    pause
    
}
#----------------------



#----------------------
#Windows-Key
function Get-WindowsKey{
    param(
        $WindowsKey
    )
    Write-Host "-------------------------------------------"
    Write-Host "Windows-Key: "
    Write-Host "-------------------------------------------"
    $WindowsKey = (Get-WmiObject SoftwareLicensingService).OA3xOriginalProductKey
    $WindowsKey | clip
    Write-Host -NoNewline "Der Windows-Key " 
    Write-Host -NoNewline -ForegroundColor Yellow $WindowsKey 
    Write-Host " befindet sich jetzt in Ihrer Zwischenablage!"
    pause
}
#----------------------


#----------------------
#Zusammenfassung
function Get-Summary{
    Clear-Host
    Write-Host -ForegroundColor Yellow "Zusammenfassung:"
    Write-Host -ForegroundColor Yellow "Hostname:"
    Write-Host $hostname 
    Write-Host -ForegroundColor Yellow "Seriennummer:"
    Write-Host $serial 
    Write-Host -ForegroundColor Yellow "Modell:" 
    Write-Host $Modell 
    Write-Host -ForegroundColor Yellow "Installiert am:"
    Write-Host $installdate 
    Write-Host -ForegroundColor Yellow "IP-Adresse:"
    Write-Host $ip 
    Write-Host -ForegroundColor Yellow "Mac-Adresse:"
    Write-Host $mac 
    Write-Host -ForegroundColor Yellow "Gateway:"
    Write-Host $gateway 
    Write-Host -ForegroundColor Yellow  "Betriebssystem:"
    Write-Host $os 
    Write-Host -ForegroundColor Yellow "Windows-Key:"
    Write-Host $WindowsKey 
    Write-Host "End of SL-Doc"
}
#----------------------


Clear-Host

write-host "`n"
Write-Host "Welcome to SL-Doc" 
Write-Host "-------------------------------------------"
Write-Host "Wir werden nacheinander alle relevanten Systemdaten auslesen und in Ihre Zwischenablage kopieren!" 
write-host "`n"

Get-Hostname
Get-Serial
Get-Modell
Get-InstallDate
Get-IPAddress
Get-MacAddress
Get-Gateway
Get-OS
Get-WindowsKey
Get-Summary


}#Ende SL-Doc







function Cleanup{

}


function Install{

    Write-Host -ForegroundColor Green "Waehle die zu installierende Software aus!"


}

function Remove{
    Write-Host  -ForegroundColor Green "Waehle die zu deinstallierende Software aus!"

    function RemoveServerEye{

    }
}


function Netdoc{
    Write-Host -ForegroundColor Green "Waehle dein Netdoc-Tool aus!"
}


function Connect{
    Write-Host -ForegroundColor Green "Wohin moechtest du dich connecten?"
}

function Standard{
    Write-Host -ForegroundColor Green "Welche Standards willst du ausrollen?!"
}

function SQL{
    Write-Host -ForegroundColor Green "Welche SQL-Daten brauchst du?"
}

function Deploy{
    Write-Host -ForegroundColor Green "Was willst du deployen?"
}






ModuleStarted