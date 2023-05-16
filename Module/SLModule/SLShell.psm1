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
    if($Secure){
        $InputVar = Read-Host -MaskInput
    }
    else{
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
function ExoDoc{
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

#Hilft bei der Standard-Netzwerk-Fehlerbehebung
function Netdoc {
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
   
   
   Ausgabe "Waehle dein Netdoc-Tool aus!" Green
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



#Startet die Ausgabe für den Willkommenstext + Erklärung
ModuleStarted



