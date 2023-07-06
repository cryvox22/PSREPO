#Get-Date ist ein Objekt des Typs Datum


Get-Date
(Get-Date).GetType()                                            #Den Objekt-Typ anzeigen
Get-Date | Get-Member                                           #Was kann man damit tun
(Get-Date).AddDays(-21)                                         #Mit dem Objekt-Typ Datum rechnen
(Get-Date).                                                     #Was gibt es so alles?
(Get-Date) - (Get-Date -Day 22 -Month 09 -Year 1998)            #Wie viele Tage bin ich schon auf dieser Welt?



### String-Objekte


'Patrick'.GetType()                      # Patrick ist eine Zeichenkette und kein Datum
'Patrick' | Get-Member                   # Was kann man damit tun? 
'patrick'.Substring(0, 1).ToUpper()       # Das erste Zeichen aufrufen und in Großbuchstaben setzen
'patrick'.AddDays(-21)                   # ?



#Unterscheidung der Objekttypen



(Get-Date).Substring(0, 2)               # Funktioniert nicht, da keine Zeichenkette

(Get-Date).ToString().Substring(0, 2)    # Ein Datumsobjekt in einen STring umwandeln

(Get-Date) - 'Patrick'                  # Geht natürlich auch nicht



#Attribute abrufen: 

Get-Process | Get-Member
#Ruft alle Attribute ab

Get-Process | Get-Member -MemberType Properties
#Ruft die Attribute genauer ab 

Get-Process explorer | Select-Object -Property * 
#Alle Attribute des Prozesses explorer werden abgerufen

Get-Process code | Select-Object ProcessName, CPU
#Bestimmte Attribute des Prozesses Code werden abgerufen

Get-Process Code | Select-Object -ExpandProperty CPU 
#Nur der bestimmte Wert wird abgerufen

(Get-Process explorer).CPU
#Alternative Schreibweise


#Um etwas zu tun

Get-Process | Where-Object CPU -GT 10
$oneDrive = $env:OneDriveConsumer + '\dokumente\privat\09_learning\powershell'
Get-Process | Where-Object CPU -GT 15 | Sort-Object CPU | Select-Object ProcessName, Id, CPU | ConvertTo-Html | Add-Content $oneDrive\prozesse.html
code $oneDrive\prozesse.html
Start-Process $oneDrive\prozesse.html



#In AD ist Vorsicht geboten

Get-ADUser -Identity administrator | Get-Member
#Attribute sind etwas wenig

Get-ADUser -Identity administrator -Properties * | Get-Member
#Alle Attribute müssen extra abgerufen werden

Get-Aduser -Identity administrator | Select-Object * 
#Ebenfalls zu wenig

Get-ADUser -Identity administrator -Properties * | Select-Object LastLogonDate
#Gut aber nicht perfekt

Get-ADUser -Identity administrator -Properties LastLogonDate | Select-Object LastLogonDate
#Deutlich performanter, da man nicht zuerst alles abruft und dann Filtert

(Get-ADUser -Identity administrator -Properties LastLogonDate | Select-Object LastLogonDate).LastLogonDate


#Count-Methode
(Get-ADUser -Filter *).Count
Get-ADUser -Filter * | Measure-Object
#Alternative
Get-ADUser -Filter * | Measure-Object | Select-Object -ExpandProperty Count
#Alternative2



(Get-ADUser -Properties Surname -Filter * | Where-Object Surname -EQ 'Gentner').count

Write-Host $countGentners -ForegroundColor Yellow


Get-ADUser -Filter * | Get-Member
Get-ChildItem | Get-Member

#Count ist ein Alias für Länge


Get-ChildItem -path C:\Users\p.gentner\Downloads\ -File *.ps1 | Get-Member -MemberType Properties
(Get-ChildItem -path $onedrive | Select-Object -First 1).Name
Get-ChildItem -path C:\Users\p.gentner\Downloads\ -File *.ps1 | Where-Object CreationTime -gt (get-date).AddMinutes(-15) | Move-Item -Destination (Get-ChildItem -path $onedrive | Select-Object -First 1).FullName



Methoden: 

Get-Service | Get-Member
Get-Service | Get-Member -MemberType Method
(Get-Service Spooler).Stop()

Stop-Service Spooler 

#Methoden sind für die entsprechenden Objekte definierte Funktionen, die ggf. noch mit Parametern bestückt werrden



$Player1 = New-Object System.Media.SoundPlayer "$env:windir\Media\windows logon.wav"
$Player1 | Get-Member
$player1.PlayLooping()
Start-Sleep 10
$Player1.Stop()
#Erstellt ein Objekt und lässt mittels Methode einen Loop laufen und stoppen



#Datentypen

'Patrick'.GetType() #Zeichenkette
(Get-Process).GetType() #Array
(Get-Process explorer).GetType() #Prozess
(Get-ADUser -Identity administrator).GetType() # ADUser




#Strings manipulieren


$name = "Patrick . Gentner @ outlook.de   "

#$name | Get-Member


#Ziel: patrickgentner@outlook.com


$resultat = $name.Trim().Replace(' ', '').Replace('outlook.de', 'outlook.com').ToLower()

#Wurden die letzten Zeichen mit Trim auch entfernt?

if($name.Length -gt $resultat.Length){
    Write-Host -ForegroundColor Cyan "Die Leerzeichen am Ende wurden ebenfalls entfernt!"
    Write-Host -ForegroundColor Green $resultat " ist " $resultat.length " Zeichen lang!"
}



#Gegeben: patrick.gentner@outlook.com
#Ziel:  Patrick Gentner


$index = $resultat.IndexOf('@')
$nameneu = $resultat.Substring(0, $index)
$split = $nameneu.Split('.')
$split -join ', ' #Exkurs -join

$split[0].Substring(0,1).ToUpper() + $split[0].Substring(1) + ' ' +$split[1].Substring(0,1).ToUpper()+$split[1].Substring(1)