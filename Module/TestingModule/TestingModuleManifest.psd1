@{
    RootModule = 'TestingModule.psm1'

    ModuleVersion = '0.0.1'

    CompanyName = 'SL Service & Verwaltungs GmbH'

    GUID = 'f493f377-768e-4160-95ae-2d7df10d1a45'
    
    Author = 'Patrick Gentner'

    Description = 'Das ist nur ein Test'

    #Importiert und Lädt die Module, die nicht da sind direkt
    #RequiredModules = @("SomeRandomModule")

    #NestedModules = @()



    #nur diese Funktionen sind für den User erreichbar (private und public Functions)
    #FuntctionsToExport = @("CallKitkat")


    PrivateData = @{

        PSData = @{

            Tags = @("PSMODULE")
        }
    }

    #Prefix für alle Funktionen des Modules z.B. Get-GCAllKitkat
    DefaultcommandPrefix = 'PG-'

}