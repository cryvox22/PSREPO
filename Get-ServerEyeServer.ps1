
function InstallSE{
# Version 2.0
# Author: Thomas Krammes
# Author: Andreas Behr
#
# Weitere Informationen zu diesem Skript finden Sie hier:
# https://servereye.freshdesk.com/support/solutions/articles/14000062437

# Die folgenden Werte muessen angepasst werden
$customer="41431524"
$secret="3cbe98f3-49ac-48bd-92ae-f6fa28e4b404"
$templateid="ecbdfc89-c22a-4406-b489-e561e903d23e"
$apikey=""
$parentGuid="c656b989-68fe-41a0-abc8-d0d0807c92c2"
$logdatei="c:\se_install_log.txt"
$remoteLog="\\fileserver\se_install\$env:computername.txt"
# Proxy if needed etc. "http://10.50.2.30:8080"
$proxy = $null
# Ändern auf $true wenn keine Log bei bestehender Installtion gewünscht sind
$noinstallLog = $false

#
# Aendern Sie bitte nichts unterhalb dieser Zeile
#

# Download der aktuellen Version
$WebClient = New-Object System.Net.WebClient
$WebProxy = New-Object System.Net.WebProxy($proxy,$true)
$WebClient.Proxy = $WebProxy
$WebClient.DownloadFile("https://occ.server-eye.de/download/se/Deploy-ServerEye.ps1","$env:windir\temp\ServerEye.ps1")


# Installation Server-Eye
Set-Location "$env:windir\temp"

If ($noinstallLog -eq $true){
    .\ServerEye.ps1 -Download -Install -Deploy SensorhubOnly -ParentGuid $parentGuid -Customer $customer -Secret $secret -ApplyTemplate -TemplateId $templateid -ApiKey $apikey -DeployPath "$env:windir\temp" -LogFile $logdatei -Silent -proxy $WebProxy -SkipLogInstalledCheck
}
else {
    .\ServerEye.ps1 -Download -Install -Deploy SensorhubOnly -ParentGuid $parentGuid -Customer $customer -Secret $secret -ApplyTemplate -TemplateId $templateid -ApiKey $apikey -DeployPath "$env:windir\temp" -LogFile $logdatei -Silent -proxy $WebProxy
}

}

InstallSE
