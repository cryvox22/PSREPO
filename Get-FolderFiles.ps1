function GetFolderFiles{
    #Abfrage des Pfades
    Write-Host -ForegroundColor Cyan -NoNewline "Bitte gib den Pfad des Ordners ein: "
    $FolderPath = Read-Host
    Write-Host -ForegroundColor Cyan -NoNewline "Sollen Unterordner mit eingeschlossen werden? (J/N): "
    $UserInput1 = Read-Host
    if($UserInput1 -eq "j" -or $UserInput1 -eq "J"){
        Write-Host -ForegroundColor Green "Hier deine Auflistung: "
        Get-ChildItem -Path $FolderPath -Recurse | Select-Object Name, DirectoryName | Format-Table -AutoSize
    }
    else{
        Write-Host -ForegroundColor Green "Hier deine Auflistung: "
        Get-ChildItem -Path $FolderPath | Select-Object Name, DirectoryName | Format-Table -AutoSize
    }

    Write-Host -ForegroundColor Cyan -NoNewline "Moechtest du einen weiteren Pfad pruefen? (J/N) :"
    $UserInput2 = Read-Host
    if($UserInput2 -eq "j" -or $UserInput2 -eq "J"){
        Clear-Host
        GetFolderFiles
    }
    
}

GetFolderFiles