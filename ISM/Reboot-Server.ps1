function Reboot-Server {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        Write-Host "---------------------------------------------------------------" -ForegroundColor Cyan
        Write-Host "Willkommen beim Server-Reboot von SL Service & Verwaltungs GmbH" -ForegroundColor Cyan
        Write-Host "---------------------------------------------------------------" -ForegroundColor Cyan
    }
    
    process {
        $UserInput
        $WerbasServer = "ISM-V"
        $HyperVHost = "HYPER-ISM"
        Write-Host " "
        Write-Host "---------------------------------------------------------------" -ForegroundColor Cyan
        Write-Host "Welchen Server wollen Sie neu starten?" -ForegroundColor Cyan
        Write-Host "---------------------------------------------------------------" -ForegroundColor Cyan
        Write-Host " "
        Write-Host "1. Werbas-Server (virtueller Server)" -ForegroundColor Yellow
        Write-Host "2. Kompletten Hardware-Server" -ForegroundColor Yellow
        Write-Host "3. Beenden" -ForegroundColor Yellow
        Write-Host " "
        $UserInput =Read-Host "Bitte geben Sie die entsprechende Nummer ein"

        switch ($UserInput) {
            1 { 
                Write-Host "Werbas-Server wird nun heruntergefahren!" -ForegroundColor Red
                Restart-Computer -ComputerName $WerbasServer -Wait
                if(Test-Connection $WerbasServer){
                    Write-Host "Werbas-Server wurde erfolgreich neugestartet!" -ForegroundColor Red
                }
                else{
                    Write-Host "Werbas-Server ist nicht mehr erreichbar - Bitte kontaktieren Sie die support@sl-sv.de!" -ForegroundColor Red
                }

             }
            2 { 
                Write-Host "Server-Reboot wird gestartet!" -ForegroundColor Red
                Write-Host "Werbas-Server VM wird heruntergefahren..." -ForegroundColor Red
                $ServerShutdown = Stop-Computer -ComputerName $WerbasServer &
                $ShutdownResults = $ServerShutdown | Receive-Job
                if($ShutdownResults){
                    Write-Host "Werbas-Server wurde heruntergefahren - Server-Reboot des Hosts wird gestartet!" -ForegroundColor Red
                    Restart-Computer -ComputerName $HyperVHost -Wait
                    if(Test-Connection $HyperVHost){
                        Write-Host "Host wurde neugestartet und Werbas-Server sollte in spätestens 10 Minuten wieder erreichbar sein!"
                    }
                    else{
                        Write-Host "Host ist nicht mehr erreichbar - Bitte kontaktieren Sie die support@sl-sv.de!" -ForegroundColor Red
                    }
                }
                else{
                    Write-Host "Shutdown war nicht erfolgreich - Bitte kontaktieren Sie die support@sl-sv.de!" -ForegroundColor Red
                }
                
             }
            3 {  
                Write-Host "Programm wird beendet!" -ForegroundColor Cyan
                Exit
            }
            Default {
                Write-Host "Fehlerhafte Eingabe. Das Programm wird beendet!" -ForegroundColor Cyan
                Exit
            }
        }

    }
    
    end {
        Write-Host "--------------------------------------------------------------------------------" -ForegroundColor Cyan
        Write-Host "Vielen Dank, dass Sie unser Tool verwendet haben - SL Service & Verwaltungs GmbH" -ForegroundColor Cyan
        Write-Host "--------------------------------------------------------------------------------" -ForegroundColor Cyan
    }
}


Reboot-Server