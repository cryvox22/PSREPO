<#
ToDo's für die Untermodule: 

SL-Doc: 
- Systemspecs mit auslesen -> erledigt
- Copy als zusatzbefehl angeben -> erledigt
- Teilinformationen abrufbar -> erledigt
- Get-Mac anpassen -> erleidgt
- alle Teilbereiche in eigene Functions auslagern -> erledigt
- Ausgabe und Zusammenfassung verbessern -> erledigt

Sl-Cleanup: 
- Papierkorb wird geleert und temp-files gelöscht -> erledigt

SL-Netdoc: 
- Ping 
- Ping mit Port
- tracert
- nslookup in beide Richtungen
- Ping bis unterbrochen wird

Allgemein: 
- Cmdlet für Read und Write-Host erstellen -> erledigt
- Cmdlet für Export erstellen


#>

#Funktion für vereinfachte Ausgabe mit verkürzter Syntax
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

#Funktionen für allgemeine Eingabe
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

#Vereinfachter Export von Daten
function ExportData {
    [CmdletBinding()]
    param (
        
    )
    
}

#Willkommenstext wird ausgegeben, in dem die allgemeinen Teilmodule aufgelistet und erklärt werden
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


function Doc {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [ValidateSet('Hostname', 'Serial', 'Model', 'InstallDate', 'IpAddress','MacAddress','Gateway','OS','Windowskey','Specs','Complete','Summary')]
        [string]
        $Value,

        [Parameter(Position = 1, Mandatory = $false)]
        [switch]
        $Copy
    )
   
    #Hostname wird ausgelesen
    function Get-Hostname {
        $hostname = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
        return $hostname
    }

    #Seriennummer wird ausgelsen
    function Get-Serial {
        $serial = (Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber
        return $serial
    }
    
    #Modell wird ausgelsen
    function Get-Model {
        $model = (Get-CimInstance CIM_ComputerSystem).Model 
        return $model
    }

    #Installations-Datum wird ausgelsen
    function Get-InstallDate {
        $installdate = (Get-WmiObject Win32_OperatingSystem).ConvertToDateTime( (Get-WmiObject Win32_OperatingSystem).InstallDate ) 
        return $installdate
    }

    #IP-Adresse wird ausgelesen
    function Get-IpAddress {
        $ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).ipaddress
        return $ip
    }

    #Mac-Addresse wird ausgelesen
    function Get-MacAddress {
        $mac = Get-NetAdapter | Where-Object LinkSpeed -match "1* Gbps" | Where-Object Status -eq "Up" | Select-Object -ExpandProperty "MacAddress"
        return $mac
    }

    #Gateway-Addresse wird ausgelesen
    function Get-Gateway {
        $gateway = Get-NetRoute -DestinationPrefix "0.0.0.0/0" | Select-Object -ExpandProperty "NextHop"
        return $gateway
    }

    #Betriebssystemversion wird ausgelesen
    function Get-OS {
        $os = (Get-WMIObject win32_operatingsystem).caption
        return $os
    }
    
    #Windows-Key wird ausgelesen
    function Get-WindowsKey {
        $WindowsKey = (Get-WmiObject SoftwareLicensingService).OA3xOriginalProductKey
        return $WindowsKey
    }

    function Get-Specs{
        
        function Get-Cpu(){
            $Cpu = (Get-WmiObject win32_processor).Name
            return $Cpu 
        }
        function Get-Memory(){
        $Ram = (Get-WMIObject -class Win32_Physicalmemory).Capacity
        $Riegel = 0
        foreach ($item in $ram)
        {
            $item = $item/1073741824
            $RamCapacity += $item
            <#Ausgabe "Riegel " -NoNewLine
            Ausgabe $counter -NoNewLine
            Ausgabe ": " -NoNewLine
            Ausgabe $item Cyan -NoNewLine
            Ausgabe " GB | " Cyan -NoNewLine#>
            $Riegel++
        }
        Ausgabe "RAM: " -NoNewLine
        Ausgabe $RamCapacity Cyan -NoNewLine
        Ausgabe " GB " Cyan -NoNewLine
        Ausgabe "(Anzahl Riegel: " -NoNewLine
        Ausgabe $Riegel Cyan -NoNewLine
        Ausgabe ")"
        }

        function Get-Gpu(){
            $Gpu = (get-wmiobject win32_videocontroller).name
            return $Gpu
        }

        function Get-Disks {
            $Disks = Get-WmiObject Win32_LogicalDisk | select DeviceID, Size
            Ausgabe "Festplatten: "
            foreach($item in $Disks){
                $Diskspace = $item.Size/1073741824
                Ausgabe $item.DeviceID -NoNewLine
                Ausgabe " " -NoNewLine
                Ausgabe ([System.Math]::Ceiling($Diskspace)) Cyan -NoNewLine
                Ausgabe " GB" Cyan
            }
            
        }

        Ausgabe "Systemspezifikation:" Yellow
                    Ausgabe "--------------------" Yellow
                    Ausgabe "Prozessor: " -NoNewLine
                    Ausgabe (Get-Cpu) Cyan
                    Get-Memory
                    Ausgabe "Grafikkarte: " -NoNewLine
                    Ausgabe (Get-Gpu) Cyan
                    Get-Disks  

    }
    #Zusammenfassung wird erstellt
    function Get-Summary {
        Ausgabe "-------------------------------------------" Green
        Ausgabe "Hostname: " -NoNewLine
        Ausgabe  (Get-Hostname) Yellow 
        Ausgabe "Seriennummer: " -NoNewLine
        Ausgabe (get-serial) Yellow
        Ausgabe "Modell: " -NoNewLine
        Ausgabe (get-model) Yellow
        Ausgabe "Installationsdatum: " -NoNewLine
        Ausgabe (Get-InstallDate) Yellow
        Ausgabe "IP-Adresse: " -NoNewLine
        Ausgabe (get-ipaddress) Yellow
        Ausgabe "Mac-Adresse: " -NoNewLine
        Ausgabe (get-MacAddress) Yellow
        Ausgabe "Gateway: " -NoNewLine
        Ausgabe (Get-gateway) Yellow
        Ausgabe "Betriebssystem: " -NoNewLine
        Ausgabe (get-OS) Yellow
        Ausgabe "Windows-Key: " -NoNewLine
        Ausgabe (get-WindowsKey) Yellow
        Ausgabe "-------------------------------------------" Green
    }

   

    If ($Value) {
        switch ($Value) {
            Hostname { 
                if($Copy){
                    Ausgabe (Get-Hostname) Green
                    Get-Hostname | Set-Clipboard
                } 
                else{
                    Ausgabe (Get-Hostname) Green
                }
            }
            Serial {
                if($Copy){
                    Ausgabe (Get-Serial) Green
                    Get-Serial | Set-Clipboard
                } 
                else{
                    Ausgabe (Get-Serial) Green
                 }
                
            }
            Model { 
                if($copy){
                    Ausgabe (Get-Model) Green
                    Get-Model | Set-Clipboard
                }
                else{
                    Ausgabe (Get-Model) Green
                }
            }
            InstallDate {
                if($Copy){
                    Ausgabe (Get-InstallDate) Green
                    Get-InstallDate | Set-Clipboard
                }
                else{
                    Ausgabe (Get-InstallDate) Green
                    Get-InstallDate | Set-Clipboard
                }
            } 
            IPAddress{
                if($Copy){
                    Ausgabe (Get-IpAddress) Green
                    Get-IpAddress | Set-Clipboard
                }
                else{
                    Ausgabe (Get-IpAddress) Green
                }
            }
            MacAddress{
                if($Copy){
                    Ausgabe (Get-MacAddress) Green
                    Get-MacAddress | Set-Clipboard
                } 
                else{ 
                    Ausgabe (Get-MacAddress) Green
                }
            }
            Gateway{
                if($Copy){
                    Ausgabe (Get-Gateway) Green
                    Get-Gateway | Set-Clipboard
                }
                else{
                    Ausgabe (Get-Gateway) Green
                }
            }
            OS { 
                if($Copy){
                    Ausgabe (Get-OS) Green
                    Get-OS | Set-Clipboard
                }
                else{
                    Ausgabe (Get-OS) Green
                }
            }
            Windowskey { 
                if($Copy){
                    Ausgabe (Get-WindowsKey) Green
                    Get-WindowsKey | Set-Clipboard
                }
                else{
                    Ausgabe (Get-WindowsKey) Green
                }
            }
            Specs{
                    Get-Specs                  
            }
            Summary { Get-Summary }

            Complete{
                Get-Summary
                Get-Specs
            }

            Default { Get-Summary }
        }
    }
}

function Cleanup {
    [CmdletBinding()]
    Param(
        $tempfolders = @( "C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Documents and Settings\*\Local Settings\temp\*", "C:\Users\*\Appdata\Local\Temp\*")
    )
    Remove-Item $tempfolders -force -recurse -ErrorAction SilentlyContinue
    Clear-RecycleBin -Force
    Ausgabe "Cleanup wurde durchgefuehrt! Papierkorp ist geleert und Temporäre Dateien wurden geloescht!"
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



#Startet die Ausgabe für den Willkommenstext + Erklärung
ModuleStarted



