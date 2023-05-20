<#
ToDo's für die Untermodule: 

Allgemein: 
- Cmdlet für Read und Write-Host erstellen -> erledigt
- Cmdlet für Export erstellen

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
- Ping  -> erledigt
- Ping mit Port -> erledigt
- tracert -> erledigt
- nslookup in beide Richtungen -> erledigt
- Ping bis unterbrochen wird -> erledigt

SL-Utilization
- CPUintensive / RAMintensive Prozesse auflisten (Get-Process | solrt cpu -descending | select -first 10)
- ServiceOverview

SL-Connect:
- M365
- AzureAD
- ExchangeOnline

SL-ExoDoc:
- Domains auslesen
- Postfächer auslesen und exportieren (SL-Export)
- neues Postfach anlegen
- Kalenderberechtigungen auslesen und setzten
- Postfachberechtigungen auslesen und setzen

SL-Install:
- TeamViewer
- M365
- PowerShell7
- 7zip
- AdobeReader

SL-Remove:
- ServerEye

SL-Standard:
- SMBv1 deaktivieren
- Winrm aktivieren und einrichten
- ExcecutionPolicy
- DomainJoin + Hostname-Change

SL-SQL: 
- Instanzen, Datenbanken und Tabellen auslesen
    - Speicherort
    - Größe
    - ggf. Berechtigungen + User auslesen/export und setzen
- neue Datenbank / Tabelle erstellen
- Standard-SQL-Befehle abschießen


SL-Deploy:
- DC
- DNS
- DHCP
- HyperV
- Fileserver
    - mit Freigaben

SL-HVMgmt
- neue VMs
- VMs auflisten und export
- VM auswählen und start, stop 
- Snapshot erstellen
- VM Specs auslesen

SL-Fileshare:
- Berechtigungen von Ordnern auslesen und export
- Berechtigungen setzen
- neue Freigabe auslesen

SL-ADController: 
- neuen User/Gruppen erstellen
- User und Gruppen auslesen und export
- Standard OUs, Gruppen und User anlegen und erstellen
#>

#Funktion für vereinfachte Ausgabe mit verkürzter Syntax
function Ausgabe {
    <#
.SYNOPSIS
    Eine Funktion für die vereinfachte Schreibweise einer Ausgabe
.DESCRIPTION
    In einem Modul oder einen Powershellskript, in dem viele Ausgaben notwendig sind, vereinfacht diese Funktion die Anwendung
.NOTES
    Bisher kann die Funktion noch keine Ausgaben von Strings und Variablen (auch nicht mehrmals) verbinden
.LINK
    Aktuell gibt es noch keine Online-Hilfe
.EXAMPLE
    SL-Ausgabe "Das ist ein Test!" Red -NoNewLine
    Gibt den String "Das ist ein Test!" in roter Schriftfarbe und ohne die Erzeugung einer neuen Zeile aus
    SL-Ausgabe $var Green
    Gibt den Wert der Variable $var in grüner Schriftfarbe aus und erzeugt eine neue Zeilse
#>
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
    <#
.SYNOPSIS
    Ermöglicht eine Usereingabe in vereinfachter Schreibweise
.DESCRIPTION
    Sobald viele Eingaben durch User gewünscht sind, kann diese Funktion den Zeitaufwand verringern und direkt den Vorangestellten Text mit einzufügen
.NOTES
    Kein automatisches Einfügen von Doppelpunkten. Hiermit lassen sich auch farbige Prompts vor eine Eingabe voranstellen
.LINK
    Aktuell gibt es keine Online-Hilfe
.EXAMPLE
    $MeineVariable = SL-Eingabe "Bitte geben Sie etwas ein: " Green -Secure
    Erzeugt eine Usereingabe mit vorangestelltem Text in grüner Textfarbe und Maskierung des Inputs (*)
.EXAMPLE
    $MeineVariable = SL-Eingabe "Bitte geben Sie etwas ein: "
    Erzeugt eine Usereingabe mit vorangestelltem Text
#>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        $Text,
        [Parameter(Position = 1, Mandatory = $false)]
        [ValidateSet('Green', 'Red', 'Cyan', 'Yellow', 'White', 'Blue', 'Magenta')]
        [String]
        $Farbe = "White",
        [Parameter(Position = 2, Mandatory = $false)]
        [switch]
        $Secure        
    )

    Ausgabe -Text $Text": " -Farbe $Farbe -NoNewLine
    if ($Secure) {
        $InputVar = Read-Host -MaskInput
    }
    else {
        $InputVar = Read-Host
    }
    
    
    return $InputVar
}

#Vereinfachter Export von Daten
function ExportData {
    [CmdletBinding()]
    param (
        
    )
    
}

#Dokumentationsinformationen werden ausgegeben und können direkt kopiert werden
function Doc {
    <#
    .SYNOPSIS
        Dokumentationsinformationen werden ausgegeben und können direkt kopiert werden
    .DESCRIPTION
        Mittels dieser Funktion kann eine Gesamtübersicht von Systeminformationen und Specs oder Einzelne Teilbereiche ausgelesen und kopiert werden
    .NOTES
        Keine weiteren Informationen verfügbar
    .LINK
        Keine Online-Hilfe verfügbar
    .EXAMPLE
        SL-Doc -Summary
        Gibt eine Gesamtzusammenfassung aus
    .EXAMPLE
        SL-Doc -Hostname -Copy
        Gibt den Hostname aus und kopiert ihn in die Zwischenablage
    #>
    
    
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [ValidateSet('Hostname', 'Serial', 'Model', 'InstallDate', 'IpAddress', 'MacAddress', 'Gateway', 'OS', 'Windowskey', 'Specs', 'Complete', 'Summary')]
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

    function Get-Specs {
        
        function Get-Cpu() {
            $Cpu = (Get-WmiObject win32_processor).Name
            return $Cpu 
        }
        function Get-Memory() {
            $Ram = (Get-WMIObject -class Win32_Physicalmemory).Capacity
            $Riegel = 0
            foreach ($item in $ram) {
                $item = $item / 1073741824
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

        function Get-Gpu() {
            $Gpu = (get-wmiobject win32_videocontroller).name
            return $Gpu
        }

        function Get-Disks {
            $Disks = Get-WmiObject Win32_LogicalDisk | select DeviceID, Size
            Ausgabe "Festplatten: "
            foreach ($item in $Disks) {
                $Diskspace = $item.Size / 1073741824
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
                if ($Copy) {
                    Ausgabe (Get-Hostname) Green
                    Get-Hostname | Set-Clipboard
                } 
                else {
                    Ausgabe (Get-Hostname) Green
                }
            }
            Serial {
                if ($Copy) {
                    Ausgabe (Get-Serial) Green
                    Get-Serial | Set-Clipboard
                } 
                else {
                    Ausgabe (Get-Serial) Green
                }
                
            }
            Model { 
                if ($copy) {
                    Ausgabe (Get-Model) Green
                    Get-Model | Set-Clipboard
                }
                else {
                    Ausgabe (Get-Model) Green
                }
            }
            InstallDate {
                if ($Copy) {
                    Ausgabe (Get-InstallDate) Green
                    Get-InstallDate | Set-Clipboard
                }
                else {
                    Ausgabe (Get-InstallDate) Green
                    Get-InstallDate | Set-Clipboard
                }
            } 
            IPAddress {
                if ($Copy) {
                    Ausgabe (Get-IpAddress) Green
                    Get-IpAddress | Set-Clipboard
                }
                else {
                    Ausgabe (Get-IpAddress) Green
                }
            }
            MacAddress {
                if ($Copy) {
                    Ausgabe (Get-MacAddress) Green
                    Get-MacAddress | Set-Clipboard
                } 
                else { 
                    Ausgabe (Get-MacAddress) Green
                }
            }
            Gateway {
                if ($Copy) {
                    Ausgabe (Get-Gateway) Green
                    Get-Gateway | Set-Clipboard
                }
                else {
                    Ausgabe (Get-Gateway) Green
                }
            }
            OS { 
                if ($Copy) {
                    Ausgabe (Get-OS) Green
                    Get-OS | Set-Clipboard
                }
                else {
                    Ausgabe (Get-OS) Green
                }
            }
            Windowskey { 
                if ($Copy) {
                    Ausgabe (Get-WindowsKey) Green
                    Get-WindowsKey | Set-Clipboard
                }
                else {
                    Ausgabe (Get-WindowsKey) Green
                }
            }
            Specs {
                Get-Specs                  
            }
            Summary { Get-Summary }

            Complete {
                Get-Summary
                Get-Specs
            }

            Default { Get-Summary }
        }
    }
}

#Bereinigt überflüssige Dateien und löscht Papierkorb
function Cleanup {
    <#
    .SYNOPSIS
        Bereinigt die temporären Dateien und löscht den Papierkorb
    .DESCRIPTION
        Windows-Temp und Prefetch sowie die Usertemps werden gelöscht sowie der Papierkorb
    .NOTES
        Keine Zusätzlichen Parameter können mitgegeben werden
    .LINK
        Keine Online-Hilfe verfügbar
    .EXAMPLE
        SL-Cleanup
        Entfernt temp-files und löscht Papierkorb
    #>
    
    
    [CmdletBinding()]
    Param(
        $tempfolders = @( "C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Documents and Settings\*\Local Settings\temp\*", "C:\Users\*\Appdata\Local\Temp\*")
    )
    Remove-Item $tempfolders -force -recurse -ErrorAction SilentlyContinue
    Clear-RecycleBin -Force
    Ausgabe "Cleanup wurde durchgefuehrt! Papierkorp ist geleert und Temporäre Dateien wurden geloescht!"
}

#Hilft bei der Standard-Netzwerk-Fehlerbehebung
function Netdoc {
    <#
   .SYNOPSIS
    Mithilfe dieses Teilmoduls werden einfache Netzwerk-Troubleshooting-Tools angewandt
   .DESCRIPTION
    Im SL-Netco enthalten sind der Standard-Ping, Ping mit einem Port, Traceroute und ein DNS-Lookup
   .NOTES
    Dies ist die erste Version und aktuell werden noch die unformatierten Ausgaben der Befehle wie Test-NetConnection zurückgegeben 
    In V2 sollen einfache und simple Rückgaben für die Verständlichkeit bereitgestellt werden
    Die Destination kann immer als IPv4 oder Hostname angegeben werden.
   .LINK
    Aktuell ist keine Online-Hilfe verfügbar
   .EXAMPLE
    SL-Netdoc -Destination fritz.box
    SL-Netdoc -Dest fritz.box
    Sl-Netdoc fritz.box
    SL-Netdoc fritz.box -Repeat
    Alle oben genannten Befehle führen einen Standard-Ping durch (der letzte so lange, bis er unterbrochen wird) || Das "Destination" kann weggelassen werden
   .EXAMPLE
    SL-Netdoc -Dest fritz.box 443 -Type PortPing
    Führt einen Ping auf den beigefügten Port durch
   .EXAMPLE
    SL-Netdoc fritz.box -Traceroute
    Führt ein Test-Connection -Traceroute durch
   .EXAMPLE
    SL-Netdoc fritz.box -Type Nslookup
    Führt ein Nslookup zur Destination durch
   #>
    [CmdletBinding()]
    param (

        [Parameter(Position = 0, Mandatory = $true)]
        [string]
        [Alias("Dest")]
        $Destination,
    
        [Parameter(Position = 1, Mandatory = $false)]
        [Int32]
        $Port,

        [Parameter(Position = 2, Mandatory = $false)]
        [ValidateSet('Ping', 'PortPing', 'Traceroute', 'Nslookup')]
        [string]
        $Type = "Ping",

        [Parameter(Position = 3, Mandatory = $false)]
        [switch]
        $Repeat
    
    )

    if ($Port -and $Type -eq "Ping") {
        $Type = "PortPing"        
    }
    

    switch ($Type) {
        Ping {

            
            if ($Repeat) {
                Test-Connection -TargetName $Destination -Repeat
            }
            else {
                Test-Connection -ComputerName $Destination
            }
            
        }
        PortPing {
            if (!$Port) {
                Ausgabe "Sie haben keinen Port gesetzt!" Red
            }
            else {
                Test-NetConnection -Computername $Destination -Port $Port -InformationLevel Detailed
            }
        }

        Traceroute {
            if ($Port -or $Repeat) {
                Ausgabe "Traceroute erlaubt weder Ports noch den Parameter 'Repeat'" Red
            }
            else {
                Test-Connection -TargetName $Destination -Traceroute
            }
        }

        Nslookup {
            if ($Port -or $Repeat) {
                Ausgabe "Nslookup akzeptiert weder Ports noch den Parameter 'Repeat'" Red
            }
            else {
                Resolve-DnsName -Name $Destination    
            }
            
        }
    }
   
    
}

#Hilft bei RAM/CPU-Prozessübersicht
function Utilization {
    <#
    .SYNOPSIS
        Dieses Teilmodul zeigt Ram und CPU auslastung und die belastetsten Prozesse
    .EXAMPLE
        SL-Utilization
        Listet die Prozesse von RAM und CPU auf
    .EXAMPLE
        SL-Utilization -Value RAM
        SL-Utilization CPU
        Listet die Prozesse der Teilbereiche auf
    .EXAMPLE
        SL-Utilization -Counter 10
        SL-Utilization -Value CPU -Counter 10
        Erhöht die Anzahl der Prozesse auf 10
    #>
    
    
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [String]
        [ValidateSet('CPU', 'RAM')]
        $Value,

        [Parameter(Position = 1, Mandatory = $false)]
        [Int32]
        $Counter = 5
    )


    function Ram-Util {
        $Computer = Get-WmiObject -Class win32_operatingsystem
        $MemoryUsage = ((($Computer.TotalVisibleMemorySize - $Computer.FreePhysicalMemory) * 100) / $Computer.TotalVisibleMemorySize)
        Ausgabe "Aktuell verwendeter Speicher: " -NoNewLine
        Ausgabe ([System.Math]::Ceiling($MemoryUsage)) Cyan -NoNewLine
        Ausgabe "%" Cyan

        Get-WmiObject WIN32_PROCESS | Sort-Object -Property ws -Descending | Select-Object -first $Counter processname, @{Name = "Mem Usage(MB)"; Expression = { [math]::round($_.ws / 1mb) } } | Out-String
        
    }

    function CPU-Util {

        $CPUUsage = (Get-WmiObject -Class Win32_Processor).LoadPercentage
        Ausgabe "Aktuell verwendete CPU: " -NoNewLine
        Ausgabe $CPUUsage Cyan -NoNewLine
        Ausgabe "%" Cyan
        Ausgabe " "
        Get-Process | Sort-Object CPU -Descending| Select-Object -first $Counter ProcessName, CPU, WS | Out-String
        
    }


    switch ($Value) {
        CPU { 
            CPU-Util
        }
        RAM {

            Ram-Util
        }
        Default {
            Ausgabe "---CPU---" Cyan
            CPU-Util
            Ausgabe "---RAM---" Cyan
            Ram-Util
        }
    }
    
}

#Verbindet zu verschiedenen Cloud-Services (M365, Teams-Admin, ExOnline, AzureAD)
function Connect {
    <#
   .SYNOPSIS
    A short one-line action-based description, e.g. 'Tests if a function is valid'
   .DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
   .NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
   .LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
   .EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
   #>
   
    
}

#Hilft bei verschiedenen Tätigkeiten und der Fehlerbehebung von Exchange Online
function ExoDoc {
    <#
    .SYNOPSIS
        A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
}

#Installiert Anwendungen / Apps
function Install {
    <#
    .SYNOPSIS
        A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    
    
    Ausgabe "Waehle die zu installierende Software aus!" Green


}

#Entfernt Anwendungen / Apps und Dienste
function Remove {
    <#
    .SYNOPSIS
        A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    
    
    
    Ausgabe "Waehle die zu deinstallierende Software aus!" Green
    
    function RemoveServerEye {
        Ausgabe "Server-Eye wird vollstaendig entfernt..."
    }
}

#Deployed Standards für Server(VMs) und Clients
function Standard {
    <#
    .SYNOPSIS
        A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    
    
    
    Ausgabe "Welche Standards willst du ausrollen?!" Green
}

#Hilft bei der Informationsbeschaffung in SQL-Server-Umgebungen
function SQL {
    <#
   .SYNOPSIS
    A short one-line action-based description, e.g. 'Tests if a function is valid'
   .DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
   .NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
   .LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
   .EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
   #>
   
   
    Ausgabe "Welche SQL-Daten brauchst du?" Green
}

#Hilft beim Deployment von Serverrollen und deren Konfiguration
function Deploy {
    <#
    .SYNOPSIS
        A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    
    

    Ausgabe "Was willst du deployen?" Green
}

#HyperVManagement (VMs etc. erstellen, auslesen und anpassen)
function HVMgmt {
    <#
    .SYNOPSIS
        A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    
    
}

#Konfiguration, Informationsbeschaffung von Fileshares + neue Erstellung
function Fileshare {
    <#
    .SYNOPSIS
        A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    
    
}

#Konfiguration und Informationbeschaffung bei ActiveDirectory-Servern
function ADController {
    <#
    .SYNOPSIS
        A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
        A longer description of the function, its purpose, common use cases, etc.
    .NOTES
        Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
        Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
        Test-MyTestFunction -Verbose
        Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>
    
    
}

#Willkommenstext wird ausgegeben, in dem die allgemeinen Teilmodule aufgelistet und erklärt werden
function ModuleStarted {
    <#
.SYNOPSIS
    Diese Funktion dient lediglich für den Begrüßungstext 
.DESCRIPTION
    Hier werden die einzelnen Teilmodule und deren groben Funktionsweise aufgelistet.
.NOTES
    Kein Userinput möglich und keine weitere Funktion vorhanden
.LINK
    Keine Online-Hilfe verfügbar
.EXAMPLE
    keine Beispiele
#>
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
    Ausgabe "SL-Netdoc" Cyan -NoNewLine
    Ausgabe " - Tolls fuer Basic NetzwerkTroubleshooting" Green
    Ausgabe "Sl-Utilization" Cyan -NoNewLine
    Ausgabe " - gibt eine grobe Übersicht über die Auslastung des Systems" Green
    Ausgabe "SL-Connect" Cyan -NoNewLine 
    Ausgabe " - Baut Verbindungen zu verschiedenen CloudShells auf (M365, AzureAD, ExOnline, Servereye, Datto etc.)" Green
    Ausgabe "SL-ExoDoc" Cyan -NoNewLine
    Ausgabe " - Grundsätzliche Anpassungen und Informationsbeschaffung bei ExchangeOnline-Servern" Green
    Ausgabe "SL-Install" Cyan -NoNewLine
    Ausgabe " - Installiert verschiedene Anwendungen" Green
    Ausgabe "SL-Remove" Cyan -NoNewLine
    Ausgabe " - Deinstalliert verschiedene Anwendungen, Features etc." Green
    Ausgabe "SL-Standard" Cyan -NoNewLine
    Ausgabe " - Setzt Basic Settings fuer Clients und Server" Green
    Ausgabe "SL-SQL" Cyan -NoNewLine
    Ausgabe " - Hilft bei der Informationsbeschaffung im SQL-Server" Green
    Ausgabe "SL-Deploy" Cyan -NoNewLine
    Ausgabe " - Deployed verschiedene Services und Features VMs, DCs usw." Green
    Ausgabe "SL-HVMgmt" Cyan -NoNewLine
    Ausgabe " - HyperVManagement (VMs etc. erstellen, auslesen und anpassen" Green
    Ausgabe "SL-Fileshare" Cyan -NoNewLine
    Ausgabe " - Informationsbeschaffung, Anpassung und Erstellung bei Netzwerkfreigaben" Green
    Ausgabe "SL-ADController" Cyan -NoNewLine
    Ausgabe " - Informtaionsbeschaffung, Anpassung und Konfiguration von ActiveDirectory Domänen" Green
}

#Startet die Ausgabe für den Willkommenstext + Erklärung
ModuleStarted



