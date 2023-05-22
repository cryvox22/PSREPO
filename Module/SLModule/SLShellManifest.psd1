@{
    RootModule           = 'SLShell.psm1'

    ModuleVersion        = '0.0.5'

    CompanyName          = 'SL Service & Verwaltungs GmbH'

    GUID                 = '60bb15df-6684-4309-b511-0ac1f4e7d5ce'
    
    Author               = 'Patrick Gentner'

    Description          = 'Eine Sammlung der Most-Used-SL-Scripts'

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