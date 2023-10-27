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
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
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

    $ModulManifestSettings = @{
        Path = "$(Get-Location)$($ModulName).psd1"
        GUID = (New-Guid)
        Author = $env:USERNAME
        CompanyName = "Default"
        RootModule = (New-Item -Name "$($ModulName).psm1" -ItemType File).Name
        ModuleVersion = "0.0.1"
        Description = "This is a brandnew Manifest"
        Copyright = '(c) Patrick Gentner. All rights reserved.'
    }

    New-ModuleManifest @$ModulManifestSettings
}
