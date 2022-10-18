function Get-M365LicenseReport{

Install-Module AzureAD
Import-Module AzureAD


$MsolAccountSkus = Get-MsolAccountSku
$LicensedMsOnlineUsers = Get-MsolUser | Where-Object { $_.IsLicensed -eq "TRUE" }


FUNCTION Get-O365LicenseObject($AccountSkuID, $ActiveUnits, $ConsumedUnits 
, $RemainingUnits,){
    $Object = New-Object PSObject 
    $Object | add-member Noteproperty AccountSkuID $AccountSkuID                           
    $Object | add-member Noteproperty ActiveUnits $ActiveUnits
    $Object | add-member Noteproperty ConsumedUnits $ConsumedUnits
    $Object | add-member Noteproperty RemainingUnits $RemainingUnits
    $Object | add-member Noteproperty Users $Users

    return $Object
} #End O365_License_Object

Get-O365LicenseObject($MsolAccountSkus,$LicensedMsOnlineUsers,x)




$O365_Licenses = @() 

foreach($MsolAccountSku in $MsolAccountSkus){

    $AccountSkuID = $MsolAccountSku.AccountSkuID
    $ActiveUnits = $MsolAccountSku.ActiveUnits
    $ConsumedUnits = $MsolAccountSku.ConsumedUnits
    $RemainingUnits = $ActiveUnits - $ConsumedUnits

    $O365_License = O365_License_Object $AccountSkuID $ActiveUnits $ConsumedUnits $RemainingUnits
    $O365_Licenses += ,$O365_License
}

foreach($O365_License in $O365_Licenses){
    
    $Users = @()
     
    foreach($LicensedMsOnlineUser in $LicensedMsOnlineUsers){
        if($LicensedMsOnlineUser.Licenses.AccountSkuId.Contains($O365_License.AccountSkuID)){
            $Users += $LicensedMsOnlineUser.UserPrincipalName
        }
    }
    $O365_License.Users += $Users
}

}

Get-M365LicenseReport