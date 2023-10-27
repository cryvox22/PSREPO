<#
.SYNOPSIS
    New-PSModule Creation with psm1 and psd1 Files
.DESCRIPTION
    This Function creates a fresh new Module for you
.NOTES
    This is written on PowerShell 7
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.PARAMETER ModulName [string]
    This is the name used for the new Module psd1 & psm1 Files
.EXAMPLE
    New-PSModule -ModuleName Test
    Creates a new Module (psm1) and a Manifest (psd1) with the right settings
#>
function New-PSModule {
    [CmdletBinding()]
    param(
        # ModuleName
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            HelpMessage = 'Provide your Modulename'            
        )]
        [string]
        $ModulName
    )
    
    #Create Path and Guid
    $Guid = New-Guid
    $Path = "$(Get-Location)\$($ModulName).psd1"
    #$Create a Splat for cmdlet-Settings
    $ModulManifestSettings = @{
        Path = $Path
        GUID = $Guid
        Author = $env:USERNAME
        CompanyName = "Default"
        RootModule = (New-Item -Name "$($ModulName).psm1" -ItemType File).Name
        ModuleVersion = "0.0.1"
        Description = "This is a brandnew Manifest"
        Copyright = '(c) Patrick Gentner. All rights reserved.'
    }

    New-ModuleManifest @ModulManifestSettings
}
