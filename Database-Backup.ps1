

#Backup-SqlDatabase -ServerInstance XX -Database XX -BackupAction Database


function GetSqlModule{

    Write-Host -ForegroundColor Cyan "SQL-Modul-Pruefung wird durchgefuehrt..."

    if(Get-Module -ListAvailable -Name SqlServer){
        Write-Host -ForegroundColor Green "Modul ist bereits installiert!"

        Write-Host -ForegroundColor Cyan -NoNewline "Soll das Modul geupdatet werden (j/J): "
        $UserInput1 = Read-Host
        if($UserInput1 -eq "j" -or $UserInput1 -eq "J"){
            Write-Host -ForegroundColor Green "Modul wird upgedatet..."
            Update-Module -Name SqlServer -AllowClobber -Force
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

    Write-Host -ForegroundColor Cyan -NoNewline "Bitte geben Sie einen Username ein (Domaene\Username): "
    $Username = Read-Host

    Write-Host -ForegroundColor Cyan -NoNewline "Bitte geben Sie ein Passwort ein: "
    $Password = Read-Host -AsSecureString
    
    $AdminCredentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username $Password

    $LocalHostname = $env:computername
    Get-SqlInstance -Credential $AdminCredentials -MachineName $LocalHostname
}

function GetRemoteSqlInstances{


    Write-Host -ForegroundColor Cyan "SQL-Instanzen werden ausgelesen..."

    Write-Host -ForegroundColor Cyan -NoNewline "Bitte geben Sie einen Username ein (Domaene\Username): "
    $Username = Read-Host

    Write-Host -ForegroundColor Cyan -NoNewline "Bitte geben Sie ein Passwort ein: "
    $Password = Read-Host -AsSecureString
    
    $AdminCredentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username $Password

    $LocalHostname = $env:computername
    Get-SqlInstance -Credential $AdminCredentials -MachineName $LocalHostname
    
}

GetSqlModule