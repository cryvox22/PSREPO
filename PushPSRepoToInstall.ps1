function PushPSRepoToInstall{
    $SourceRepo = "C:\users\p.gentner\Documents\GitHub\PSREPO\*"
    $DestinationRepo = "\\fsrv01\psrepo"

    $SourceItems = Get-ChildItem -Path $SourceRepo -Filter *.ps1 -Recurse | Select-Object FullName
    $DestinationItems = Get-ChildItem -Path $DestinationRepo -Filter *.ps1 -Recurse | Select-Object FullName


    Write-Host -ForegroundColor Cyan "Die aktuelle Git-Hub-Version von PSRepo wird nach '$DestinationRepo' gepusht..."
    Copy-Item -Path $SourceRepo -Destination $DestinationRepo -Include *.ps1 -Recurse -Force
    Write-Host -ForegroundColor Green "Der Push war erfolgreich!"
    Write-Host -ForegroundColor Green "Folgende Dateien wurden kopiert: "
   




    $Vergleich = @($SourceItems, $DestinationItems)


    

    
    for($parentloop=0; $parentloop -lt $Vergleich.Length; $parentloop++){
        $x=$Vergleich[$parentloop][$childloop].FullName
        Write-Host $x.Remove($SourceRepo)
        for($childloop=0; $childloop -lt $Vergleich.$SourceItems.Length; $childloop++){
                
           
           Write-host $Vergleich[$parentloop][$childloop].FullName
       }
    }
    
    # 
   



}

PushPSRepoToInstall