<#
    SYNOPSIS:
            Replace File Contents

    DESCRIPTION:
            Replace any strings from the given input file with the new string and store it in a new output file

    File Details:
    =====================================================================================
    Created by: Pandiarajan
    Created on: 28-Dec-2019
    File Name: ReplaceFileContents.ps2
    URL:
    =====================================================================================
       
#>

function SearchString 
{

    [CmdletBinding()]  
    param  
    (  
        [ValidateNotNullOrEmpty()][String]$InputFile,          
        [ValidateNotNullOrEmpty()][String]$SearchString
    )
    try
    {
        ### Read all the lines and replace NL & CR by NL
        $InputContents = [IO.File]::ReadAllText($InputFile)

        ### Search the given input string and if you find them replace with new string
        ### Hence when converting Windows PPD to Linux/MAC, duplex needs to be updated
        $doesExists = $InputContents | %{$_ -match $SearchString}
        if ($doesExists -contains $true) {
	        Write-Host $SearchString exists on $InputFile
        }
        else
        {
            Write-Host $SearchString does not exists on $InputFile
        }
    }
    catch
    {
        Write-Error "Oops!!! Something wrong happened, Please check your input and output path"
    }
}

function ReplaceFileContents 
{

    [CmdletBinding()]  
    param  
    (  
        [ValidateNotNullOrEmpty()][String]$InputFile,  
        [ValidateNotNullOrEmpty()][String]$OutputFile,
        [ValidateNotNullOrEmpty()][String]$SearchString,
        [ValidateNotNullOrEmpty()][String]$NewString
        
    )
    try
    {
        ### Read all the lines and replace search string with new string
        $InputContents = [IO.File]::ReadAllText($InputFile) -replace $SearchString, $NewString
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
ReplaceFileContents -InputFile "C:\workspace\TestFile.txt" -OutputFile "C:\Workspace\TestOutput.txt" -SearchString "Are" -NewString "are"
#SearchString -InputFile "C:\workspace\TestFile.txt" -SearchString "his"
