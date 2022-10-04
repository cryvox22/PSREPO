

function DoTnc{
    # Documentation: https://learn.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection?view=windowsserver2022-ps

    Write-Host -ForegroundColor Green -NoNewline "Bitte gib einen Hostnamen oder eine IP ein: "
    $TestTarget = Read-Host

    Write-Host -ForegroundColor Green -NoNewline "Bitte gib einen Port ein: "
    $TestPort = Read-Host

    Write-Host -ForegroundColor Green -NoNewline "Möchtest du detailierte Informationen (J/N)"
    $TestDetails = Read-Host

if($TestDetails -eq "J" -or $TestDetails -eq "j"){

    Test-NetConnection $TestTarget -Port $TestPort -InformationLevel Detailed
}else{
    Test-NetConnection $TestTarget -Port $TestPort
}

    
    



}


function DoTestCon{
#Documentation: 
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection?view=powershell-7.2
#https://sid-500.com/2019/10/22/powershell-endless-ping-with-test-connection/


Write-Host -ForegroundColor Green -NoNewline "Bitte gib einen Hostnamen oder eine IP ein: "
$TestTarget = Read-Host

Write-Host -ForegroundColor Green -NoNewline "Wie oft soll der Test ausgefuehrt werden: "
$TestCount = Read-Host


Test-Connection $TestTarget -Count $TestCount



}


Write-Host -ForegroundColor Cyan "Wilkommen im Networktest-Skript!"



do{
Write-Host -ForegroundColor Cyan -NoNewline "Waehle 1 fuer detailierte Tests mit Ports, 2 fuer Basic-Ping-Tests und X fuer die Beendigung des Skripts: "
$x = Read-Host


switch ($x) {
    1 { 
        DoTnc
     }
    2 {
        DoTestCon
    }
}

cls
}while ($x -ne "x" -or $x -ne "X") {
    
}