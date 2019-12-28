<#
    SYNOPSIS:
            Remove CR from a Text file

    DESCRIPTION:
            Remove Carriage Return from the input text file and create a new text file with only NL not CR

    File Details:
    =====================================================================================
    Created by: Pandiarajan
    Created on: 28-Dec-2019
    File Name: RemoveFileCR.ps1
    URL: 
    =====================================================================================
#>


function RemoveCR 
{

    [CmdletBinding()]  
    param  
    (  
        [ValidateNotNullOrEmpty()][String]$InputFile,  
        [ValidateNotNullOrEmpty()][String]$OutputFile  
    )
    try
    {
        ### Read all the lines and replace NL & CR by NL
        $InputContents = [IO.File]::ReadAllText($InputFile) -replace "`r`n", "`n"

        ### Write the new contents into a new file
        [IO.File]::WriteAllText($OutputFile, $InputContents)

        Write-Host $InputFile was processed to remove CR and stored as a new file in $OutputFile
    }
    catch
    {
        Write-Error "Oops!!! Something wrong happened, Please check your input and output path"
    }
}

#Replace the input file path and output file path as desired in the below line
RemoveCR -InputFile "C:\workspace\TestFile.txt" -OutputFile "C:\Workspace\TestOutput.txt"
