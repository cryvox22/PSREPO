function VerstehIchNicht {
    param (
        [CmdletBinding()]
        [String]$TextInput
    )
    
    begin {
        Write-Host "Das ist dein Wert zum Anfang" $TextInput
    }
    
    process {
        if($_){

            Write-Host "Der Wert aus der Pipeline:" $_
        }
        else{
            Write-Host "Geh heim!"
        }
        
    }
    
    end {
        Write-Host "Zum Ende sag ich leise scheiße. Hier dein Wert: "$TextInput
    }
}