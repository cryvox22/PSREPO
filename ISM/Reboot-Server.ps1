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
        $WerbasServer = "CLIENT01W10"
        $HyperVHost = "HOST01"
        $user = ".\administrator"
        $WerbasSession = New-PSSession -Computer $WerbasServer
        Write-Host " "
        Write-Host "---------------------------------------------------------------" -ForegroundColor Cyan
        Write-Host "Welchen Server wollen Sie neu starten?" -ForegroundColor Cyan
        Write-Host "---------------------------------------------------------------" -ForegroundColor Cyan
        Write-Host " "
        Write-Host "1. Werbas-Server (virtueller Server)" -ForegroundColor Yellow
        Write-Host "2. Kompletten Hardware-Server" -ForegroundColor Yellow
        Write-Host "3. Verbindungstest Werbas-Server" -ForegroundColor Yellow
        Write-Host "4. Beenden" -ForegroundColor Yellow
        Write-Host " "
        $UserInput =Read-Host "Bitte geben Sie die entsprechende Nummer ein"

        switch ($UserInput) {
            1 { 
                New-PSSession -Session $WerbasSession -Credential $user
                Write-Host "Werbas-Server wird nun heruntergefahren!" -ForegroundColor Red
                Restart-VM $WerbasServer -Wait -Force
                if(Test-Connection $WerbasServer){
                    Write-Host "Werbas-Server wurde erfolgreich neugestartet!" -ForegroundColor Green
                }
                else{
                    Write-Host "Werbas-Server ist nicht mehr erreichbar - Bitte kontaktieren Sie die support@sl-sv.de!" -ForegroundColor Red
                }
             }
            2 { 
                New-PSSession -Session $WerbasSession -Credential $user
                Write-Host "Server-Reboot wird gestartet!" -ForegroundColor Red
                Write-Host "Werbas-Server VM wird heruntergefahren..." -ForegroundColor Red
                Stop-VM -Name $WerbasServer -Force
                Start-Sleep -Seconds 20 
                    Write-Host "Werbas-Server wurde heruntergefahren - Server-Reboot des Hosts wird gestartet!" -ForegroundColor Red
                    Restart-Computer -ComputerName $HyperVHost -Wait
                    if(Test-Connection $HyperVHost){
                        Start-VM $WerbasServer
                        Write-Host "Host wurde neugestartet und Werbas-Server sollte in spätestens 10 Minuten wieder erreichbar sein!" -ForegroundColor Green
                        Start-Sleep -Seconds 20
                        if(Test-Connection $WerbasServer){
                        New-PSSession -Session $WerbasSession -Credential $user
                        Write-Host "Werbas-Server wurde erfolgreich wieder gestartet!" -ForegroundColor Green
                        }
                    }
                    else{
                        Write-Host "Host ist nicht mehr erreichbar - Bitte kontaktieren Sie die support@sl-sv.de!" -ForegroundColor Red
                    }                   
             }
            4 {  
                Write-Host "Programm wird beendet!" -ForegroundColor Cyan
                Exit
            }
            3{
                if(Test-Connection $WerbasServer){
                Write-Host "Werbas Server ist erreichbar!" -ForegroundColor Green
                }
                else{
                Write-Host "Werbas Server ist nicht erreichbar!" -ForegroundColor Red
                }
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