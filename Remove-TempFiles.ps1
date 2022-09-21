[CmdletBinding()]
Param(
    $tempfolders = @( "C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Documents and Settings\*\Local Settings\temp\*", "C:\Users\*\Appdata\Local\Temp\*")
)
 
Begin {
    Write-Host -ForegroundColor Green "Script startet"
    $ExitCode = 0   
    # 0 = everything is ok
}
 
Process {
    Write-Host -ForegroundColor Green "Loeschprozess der temporären Dateien ist im Gange..."
    Remove-Item $tempfolders -force -recurse -ErrorAction SilentlyContinue
    Write-Host -ForegroundColor Green "Loeschprozess der temporären Dateien ist beendet."
    Write-Host -ForegroundColor Green "Loeschprozess des Papierkorbs ist im Gange..."
    Clear-RecycleBin -Force
    Write-Host -ForegroundColor Green "Loeschprozess des Papierkorbs ist beendet."
}
 
End {
    Write-Host -ForegroundColor Green "Script beendet"
    exit $ExitCode
}

