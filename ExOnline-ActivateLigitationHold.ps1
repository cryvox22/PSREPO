Import-Module ExcahngeOnlineManagement
Connect-ExchangeOnline 


Get-Mailbox -ResultSize Unlimited -Filter "RecipientTypeDetails -eq 'UserMailbox'" | Set-Mailbox -LitigationHoldEnabled $true -LitigationHoldDuration 3650

Set-Mailbox aad-sync@sl-sv.de -LitigationHoldEnabled $false
Set-Mailbox sicherung@sl-sv.de -LitigationHoldEnabled $false
Set-Mailbox sltest@sl-sv.de -LitigationHoldEnabled $false



Set-Mailbox ci-admin@sl-i.de -LitigationHoldEnabled $false
Set-Mailbox it@sl-i.de -LitigationHoldEnabled $false
Set-Mailbox infotag@sl-i.de -LitigationHoldEnabled $false
Set-Mailbox ci-admin@sl-i.de -LitigationHoldEnabled $false
