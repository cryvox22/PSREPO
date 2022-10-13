

#Backup-SqlDatabase -ServerInstance XX -Database XX -BackupAction Database


function GetSqlModule{

    Write-Host -ForegroundColor Cyan "SQL-Modul-Pruefung wird durchgefuehrt..."

    if(Get-Module -ListAvailable -Name SqlServer){
        Write-Host -ForegroundColor Green "Modul ist bereits installiert!"

        Write-Host -ForegroundColor Cyan -NoNewline "Soll das Modul geupdatet werden (J/N): "
        $UserInput1 = Read-Host
        if($UserInput1 -eq "j" -or $UserInput1 -eq "J"){
            Write-Host -ForegroundColor Green "Modul wird upgedatet..."
            Update-Module -Name SqlServer -Force
            Write-Host -ForegroundColor Green "Modul ist upgedatet!"
        }else{
            Write-Host -ForegroundColor Green "Modul wird nicht upgedatet!"
        }
        
    }else{
        Write-Host -ForegroundColor Green "Modul wird installiert..."
        Install-Module -Name SqlServer -Force
        Write-Host -ForegroundColor Green "Modul ist installiert!"
    }
}


function GetSqlInstances{


    Write-Host -ForegroundColor Cyan "SQL-Instanzen werden ausgelesen..."

    $LocalHostname = $env:computername
    $FilterString = "MSSQL$"
    $FilterStringLength = $FilterString.Length
    $SqlInstances = (Get-service -ComputerName $LocalHostname -Name MSSQL$* | Where-Object { $_.Status -eq "Running" }).Name.Remove(0,$FilterStringLength)
    $SqlInstances
    
}

function GetRemoteSqlInstances{

    Write-Host -ForegroundColor Cyan -NoNewline "Bitte gib den Hostnamen des SQL-Servers ein: "
    $SQLServer = Read-Host
    Write-Host -ForegroundColor Cyan "SQL-Instanzen werden ausgelesen..."
    
    $FilterString = "MSSQL$"
    $FilterStringLength = $FilterString.Length
    $SqlInstances = (Get-service -ComputerName $SQLServer -Name MSSQL$* | Where-Object { $_.Status -eq "Running" }).Name.Remove(0,$FilterStringLength)
    $SqlInstances
        
}


function GetSQLDatabases{
    
}


GetSqlModule

Write-Host -ForegroundColor Cyan -NoNewline "Moechtest du einen Remote-SQL-Server auslesen (J/N)?: "
$UserInput1 = Read-Host
if($UserInput1 -eq "j" -or $UserInput1 -eq "J"){
    GetRemoteSqlInstances
}else{
    GetSqlInstances
}