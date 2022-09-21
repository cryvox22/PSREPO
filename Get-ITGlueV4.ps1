#----------------------
#Variablen: 
#----------------------



$DesktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$hostname = (Get-CimInstance -ClassName Win32_ComputerSystem).Name


$filepath = $DesktopPath + "\PC-Info-"+ $hostname + ".txt"



Start-Transcript $filepath

#----------------------
#Programm
#----------------------


$serial = (Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber
$system = Get-CimInstance CIM_ComputerSystem
$Modell = $system.Model
$installdate = (Get-WmiObject Win32_OperatingSystem).ConvertToDateTime( (Get-WmiObject Win32_OperatingSystem).InstallDate ) 
$ip =  (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).ipaddress
$mac =  (Get-NetAdapter -Name Ethernet).macaddress
$gateway = Get-NetRoute -DestinationPrefix "0.0.0.0/0" | Select-Object -ExpandProperty "NextHop"
$os = (Get-WMIObject win32_operatingsystem).caption
$WindowsKey = (Get-WmiObject SoftwareLicensingService).OA3xOriginalProductKey



$hostname
$serial
$system
$Modell
$installdate
$ip
$mac
$gateway
$os
$WindowsKey





#----------------------
#Programm Ende
#----------------------

Stop-Transcript