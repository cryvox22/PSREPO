write-host "`n"
Write-Host -ForegroundColor Green "Willkommen beim Connect-ServerEye!"
Write-Host "------------------------------------"
write-host "`n"

#https://servereye.freshdesk.com/support/solutions/articles/14000070083-installation-powershell-helper-modul
#https://servereye.freshdesk.com/support/solutions/articles/14000088986-anlegen-einer-alarmierung-bei-allen-sensoren-eines-kunden-mit-verz%C3%B6gerung-und-filterung-nach-tags-

#Info UserIDs:
#Username                            EMail                            UserID
#--------                            -----                            ------
#IT Innovativ                        it@sl-i.de                       1a6f13e5-0ae1-4880-aaed-8a49c20032fd
#Support SLSV                        support@sl-sv.de                 022cda07-9f9d-4fe7-b179-40aebd78d4c6
#Patrick Gentner                     p.gentner@sl-sv.de               2ef1a01a-1605-4216-a569-edf96c982176
#Marco Kalb                          m.kalb@sl-sv.de                  43145fdf-e68f-4177-878f-798637307478
#Administratoren                                                      b4fed7dd-2daf-48db-89df-7f0113d275e4
#Daniela Müller                      d.mueller@sl-sv.de               c03d26fb-c0ce-46e0-b84f-10bb378ae7f1
#Robert Andreas Savu                 r.savu@sl-sv.de                  e3a8563d-2867-4dc1-89a1-5bcb1ff609b7
#Jens Delert                         j.delert@sl-sv.de                e7616b82-f48e-4877-a794-81eb1e1b8f82


$useridsupport = "1a6f13e5-0ae1-4880-aaed-8a49c20032fd"
$useridgentner = "2ef1a01a-1605-4216-a569-edf96c982176"
$useriddelert = "e7616b82-f48e-4877-a794-81eb1e1b8f82"




if (!(Get-Module "ServerEye.Powershell.Helper")) {
    # module is not loaded
    Install-Module -Name ServerEye.Powershell.Helper
}
Import-Module -Name ServerEye.Powershell.Helper
Update-SEHelper

Connect-SESession -persist


Write-Host -ForegroundColor Blue "Liste Kunden auf..."
Get-SECustomer

Write-Host -ForegroundColor Blue -NoNewline "Moechtest du eine Alarmierung hinzufuegen? (J/N)"
$input1 = Read-Host 
if($input1 -eq "j" -or $input1 -eq "J"){
    Write-Host -ForegroundColor Blue -NoNewline "Bitte gib den Kundennamen ein"
    $inputCustomer = Read-Host
    
    Write-Host -ForegroundColor Blue -NoNewline "Wer soll die Alarmierung erhalten? (JD = Jens Delert, PG = Patrick Gentner, Support = support@sl-sv.de)"
    $inputAlarmreceiver = Read-Host

    if($inputAlarmreceiver -eq "JD" -or $inputAlarmreceiver -eq "jd"){
        $AlarmReceiver = $useriddelert
    }elseif($inputAlarmreceiver -eq "PG" -or $inputAlarmreceiver -eq "pg"){
        $AlarmReceiver = $useridgentner
    }else{
        $AlarmReceiver = $useridsupport
    }

    Get-SECustomer -Filter $inputCustomer | Get-Sensor -Filter * | New-SENotification -UserID $AlarmReceiver
    Get-SECustomer -Filter "SL Service & Verwaltungs GmbH" | Get-SESensorhub -Filter "MKS01" | Get-SESensor -Filter "7524ed5e-6a47-411d-8028-7bb67a53a596" | New-SENotification -UserId "2ef1a01a-1605-4216-a569-edf96c982176" -SendEmail
}

Write-Host -ForegroundColor Green -NoNewline "Zum Beenden eine beliebige Taste druecken!"
Read-Host