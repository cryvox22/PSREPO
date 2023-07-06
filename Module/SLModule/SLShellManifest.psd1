@{
    RootModule           = 'SLShell.psm1'

    ModuleVersion        = '0.5.0'

    CompanyName          = 'Patrick Gentner - EDV-Service'

    GUID                 = '60bb15df-6684-4309-b511-0ac1f4e7d5ce'
    
    Author               = 'Patrick Gentner'

    Description          = 'Eine Sammlung verschiedener Scripts für Standard und/oder specialiced Tasks im IT-Systemhaus-Alltag'

    #Importiert und Lädt die Module, die nicht da sind direkt
    #RequiredModules = @("SomeRandomModule")

    #NestedModules = @()



    #nur diese Funktionen sind für den User erreichbar (private und public Functions)
    #FuntctionsToExport = @("CallKitkat")


    PrivateData          = @{

        PSData = @{

            Tags = @("PSMODULE")
        }
    }

    #Prefix für alle Funktionen des Modules z.B. Get-GCAllKitkat
    DefaultcommandPrefix = 'SL-'

}