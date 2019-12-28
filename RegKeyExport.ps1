<#
    SYNOPSIS:
            Regsitry export

    DESCRIPTION:
            Export the given registry entries into a .reg file

    File Details:
    =====================================================================================
    Created by: Pandiarajan
    Created on: 28-Dec-2019
    File Name: RegKeyExport.ps1
    URL: 
    =====================================================================================
#>

function RegistryExport{
    # Inputs (What are the inputs to this scripts?)
    #       folder = folder name where the registry files will be stored.
    #       filename = name of the registry file where the registry entries will be stored

    # Process (What the script does?)
    #         1. Define the registry entries that are needs to be exported and full file name where registry  entries to be stored.
    #         2. If the registry file exists stop the execution, don't continue
    #         3. Create a temporary folder to store different registry entires and export all the registry entries in temp folder
    #         4. Merge all the different registry entires in the temporary folder and save it to filename given as input
    #         5. Delete the temporary folder and exit the script

    # Output (What the script produces?)
    #        error : if the registry settings file exists
    #        success : registry settings file as stored as .reg file in the given path

    [CmdletBinding()]  
    param  
    (  
        [ValidateNotNullOrEmpty()][String]$FolderPath,  
        [ValidateNotNullOrEmpty()][String]$RegFile  
    )

    #1. Define the registry entries that are needs to be exported
    $reg_keys_to_export = 'HKCU\Software\sqlitebrowser', 'HKCU\Software\WixSharp'
    $files_to_export = Join-Path -Path $FolderPath -ChildPath $RegFile

    #2. If the registry file exists stop the execution, don't continue
    if((Test-Path $files_to_export))
    {
        Write-Error "error!!! export file already exists, hence no action!!!"
        exit 0
    }

    #3. Create a temporary folder to store different registry entires and export all the registry entries in temp folder
    New-Item -Path "$FolderPath\temp" -ItemType Directory
    $reg_keys_to_export | % {
        $index++
        & REG export $_ "$FolderPath\temp\$index.reg"
    }

    #4. Merge all the different registry entires in the temporary folder and save it to filename given as input
    'Windows Registry Editor Version 5.00' | Set-Content $files_to_export
    Get-Content "$FolderPath\temp\*.reg" | ? {
      $_ -ne 'Windows Registry Editor Version 5.00'
    } | Add-Content $files_to_export

    #5. Delete the temporary folder and exit the script
    Remove-Item -Path "$FolderPath\temp" -Recurse -Force
    Write-Host "$files_to_export is generated successfully"
}

#Replace the FolderPath and RegFile in the below line
RegistryExport -FolderPath "C:\Workspace" -RegFile "Test.reg"
