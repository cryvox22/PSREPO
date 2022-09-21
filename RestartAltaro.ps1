

#Funktionen: 

function RestartAltaroServices {
    Write-Host -ForegroundColor Blue "Altaro Services werden beendet..."
    Stop-service -Name *Altaro*
    Write-Host -ForegroundColor Blue "Altaro Services wurden erfolgreich beendet!"

    Write-Host -ForegroundColor Blue "Altaro Services werden gestartet..."
    Start-Service -Name *altaro*
    Write-Host -ForegroundColor Blue "Altaro Services wurden erfolgreich gestartet!"
}


#Main:

Write-Host -ForegroundColor Green "Willkommen beim Altaro-Service-Restarter!"

RestartAltaroServices

Write-Host -ForegroundColor Green "Altaro-Service-Restarter wird nun beendet!"