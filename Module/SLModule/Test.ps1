function VerstehIchNicht {
    param (
        [CmdletBinding()]
        [String]$TextInput
    )
    
    begin {
        Write-Host "Das ist dein Wert zum Anfang" $TextInput
    }
    
    process {
        if($_){
            $returnvar = $_ 
            Write-Host "Der Wert aus der Pipeline:" $returnvar
        }
        else{
            Write-Host "Geh heim!"
        }
        
    }
    
    end {
        Write-Host "Zum Ende sag ich leise scheiße. Hier dein Wert: "$TextInput
    }
}

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
}elseif(!$_){
    $InputVar = Read-Host
    return $InputVar
}
else {
    $InputVar = Read-Host
}


return $InputVar
}