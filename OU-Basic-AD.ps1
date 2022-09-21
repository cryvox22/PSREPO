#Import-Module ServerManager
#Add-WindowsFeature -Name "RSAT-AD-PowerShell" -IncludeAllSubFeature
#Get-WindowsFeature RSAT-AD-PowerShell
Install-Module -Name WindowsCompatibility
#Enable-WindowsOptionalFeature -Online -FeatureName RSATClient-Roles-AD-Powershell
#Add-WindowsCapability -online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0-"
Import-Module ActiveDirectory

# !Hier werden alle notwendigen Module installiert!

#Variablen
$Domaenenname = (Get-ADDomain).Name
$BasisOU = (Get-ADDomain).DistinguishedName


$OUName = ""
$GruppenName = ""



#OU Anlegen

#BASIS OU definieren (Firmenname + Basis OU)
$Firmenname = Read-Host("Bitte geben Sie Ihren Firmennamen ein: ")

New-ADOrganizationalUnit -Name $Firmenname -Path $BasisOU
$BasisOU = "OU="+ $Firmenname+ "," +$BasisOU


#Basis OUs anlegen
New-ADOrganizationalUnit -Name "Computer" -Path $BasisOU
New-ADOrganizationalUnit -Name "Benutzer" -Path $BasisOU
New-ADOrganizationalUnit -Name "Server" -Path $BasisOU
New-ADOrganizationalUnit -Name "Freigaben" -Path $BasisOU
New-ADOrganizationalUnit -Name "Gruppen" -Path $BasisOU
$BasisOUGruppen = "OU=Gruppen," +$BasisOU
New-ADOrganizationalUnit -Name "Domaenenlokale-Gruppen" -Path $BasisOUGruppen
New-ADOrganizationalUnit -Name "Globale-Gruppen" -Path $BasisOUGruppen
$BasisOUComputer = "OU=Computer," +$BasisOU
New-ADOrganizationalUnit -Name "Notebooks" -Path $BasisOUComputer
$BasisOUBenutzer = "OU=Benutzer," +$BasisOU
New-ADOrganizationalUnit -Name "Administratoren" -Path $BasisOUBenutzer
New-ADOrganizationalUnit -Name "Mitarbeiter" -Path $BasisOUBenutzer
New-ADOrganizationalUnit -Name "Geschaeftsleitung" -Path $BasisOUBenutzer

#StandardOUs als Variable speichern

#Standard-OU fuer Computer Aendern
redircmp $BasisOUComputer

#Standard-OU fuer Benutzer Aendern
redirusr $BasisOUBenutzer


#Securitygroups anlegen
$BasisOUGruppenGlobal= "OU=Globale-Gruppen," +$BasisOUGruppen
$BasisOUGruppenDLokal="OU=Domaenenlokale-Gruppen," +$BasisOUGruppen
New-ADGroup -Name "G-Administratoren" -GroupCategory Security -GroupScope Global -DisplayName "G-Administratoren" -Path $BasisOUGruppenGlobal
New-ADGroup -Name "G-Mitarbeiter" -GroupCategory Security -GroupScope Global -DisplayName "G-Mitarbeiter" -Path $BasisOUGruppenGlobal
New-ADGroup -Name "G-Geschäftsleitung" -GroupCategory Security -GroupScope Global -DisplayName "G-Geschäftsleitung" -Path $BasisOUGruppenGlobal
New-ADGroup -Name "DL-NWS-Install-lesen" -GroupCategory Security -GroupScope DomainLocal -DisplayName "DL-NWS-Install-lesen" -Path $BasisOUGruppenDLokal
New-ADGroup -Name "DL-NWS-Install-schreiben" -GroupCategory Security -GroupScope DomainLocal -DisplayName "DL-NWS-Install-schreiben" -Path $BasisOUGruppenDLokal
New-ADGroup -Name "DL-NWS-Install-vollzugriff" -GroupCategory Security -GroupScope DomainLocal -DisplayName "DL-NWS-Install-vollzugriff" -Path $BasisOUGruppenDLokal
New-ADGroup -Name "DL-NWS-Scan-lesen" -GroupCategory Security -GroupScope DomainLocal -DisplayName "DL-NWS-Scan-lesen" -Path $BasisOUGruppenDLokal
New-ADGroup -Name "DL-NWS-Scan-schreiben" -GroupCategory Security -GroupScope DomainLocal -DisplayName "DL-NWS-Scan-schreiben" -Path $BasisOUGruppenDLokal
New-ADGroup -Name "DL-NWS-Scan-vollzugriff" -GroupCategory Security -GroupScope DomainLocal -DisplayName "DL-NWS-Scan-vollzugriff" -Path $BasisOUGruppenDLokal
New-ADGroup -Name "DL-NWS-Geschäftsleitung-lesen" -GroupCategory Security -GroupScope DomainLocal -DisplayName "DL-NWS-Geschäftsleitung-lesen" -Path $BasisOUGruppenDLokal
New-ADGroup -Name "DL-NWS-Geschäftsleitung-schreiben" -GroupCategory Security -GroupScope DomainLocal -DisplayName "DL-NWS-Geschäftsleitung-schreiben" -Path $BasisOUGruppenDLokal
New-ADGroup -Name "DL-NWS-Geschäftsleitung-vollzugriff" -GroupCategory Security -GroupScope DomainLocal -DisplayName "DL-NWS-Geschäftsleitung-vollzugriff" -Path $BasisOUGruppenDLokal
