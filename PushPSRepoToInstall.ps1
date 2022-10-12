function PushPSRepoToInstall{
    $SourceRepo = "C:\users\p.gentner\Documents\GitHub\PSREPO\*"
    $DestinationRepo = "\\fsrv01\psrepo"

    Write-Host -ForegroundColor Cyan "Die aktuelle Git-Hub-Version von PSRepo wird nach '$DestinationRepo' gepusht..."
    Copy-Item -Path $SourceRepo -Destination $DestinationRepo -Include *.ps1 -Recurse -Force
    Write-Host -ForegroundColor Green "Der Push war erfolgreich!"
    Write-Host -ForegroundColor Green "Folgende Dateien wurden kopiert: "
    Get-ChildItem -Path $SourceRepo -Filter *.ps1 -Recurse | Select-Object FullName

}