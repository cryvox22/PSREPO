write-host "`n"
Write-Host -ForegroundColor Green "Willkommen beim Connect-ServerEye!"
Write-Host "------------------------------------"
write-host "`n"
Write-Host -ForegroundColor Blue "Der TeamViewer wird installiert..."
write-host "`n"



if (!(Get-Module "ServerEye.Powershell.Helper")) {
    # module is not loaded
    Install-Module -Name ServerEye.Powershell.Helper
}
Import-Module -Name ServerEye.Powershell.Helper

Connect-SESession -persist
