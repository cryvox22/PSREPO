Import-Module -Name SophosEndpoints

$IPorName = "192.168.2.254"
$Port = "4444"
$UtmApiKey = "KLCXIqxZcKLPMRPBoUYAUbvPjXzBRgTU"
$TenantName = "slsvde"

$LogFilePath = "C:\LogFiles\O365-Endpoint-Update.log"
$UtmApiUrl = "https://" + "$IPorName" + ":$Port/api"

Set-EndpointsInUtm -UtmApiUrl $UtmApiUrl -UtmApiKey $UtmApiKey -TenantName $TenantName



