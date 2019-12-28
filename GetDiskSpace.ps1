<#
    SYNOPSIS:
            GetDiskSpace

    DESCRIPTION:
            Get Disk space details of the given computer, though the driver is completly hidden

    File Details:
    =====================================================================================
    Created by: Pandiarajan
    Created on: 28-Dec-2019
    File Name: GetDiskSpace.ps1
    URL: 
    =====================================================================================
#>

# Display the drive space on all drives
function DriveSpace {

        [CmdletBinding()]  
    param  
    (  
        [ValidateNotNullOrEmpty()][String]$ComputerName
    )

 "--------------------------------------------"
 "Drive Details : $ComputerName"
 # Get the Disks for this computer
 $colDisks = get-wmiobject Win32_LogicalDisk -computername $ComputerName -Filter "DriveType = 3"
 $freeSize = $colDisks[0].FreeSpace / (1024*1024*1024)
 $fullSize = $colDisks[0].Size / (1024*1024*1024)
 
    # For each disk calculate the free space
	"--------------------------------------------"
	"Drive - FullSize(GB)     - FreeSize(GB)"
    foreach ($disk in $colDisks) {
	   $freeSize = $disk.FreeSpace / (1024*1024*1024)
	   $fullSize = $disk.Size / (1024*1024*1024)
	   $Drive = $disk.DeviceID
	   "$Drive    - $fullSize - $freeSize"
    } 
	"--------------------------------------------"
}

#Enter your computer host name as a input to the below function DriveSpace
# Example DESKTOP-ABCDEF is my laptop name.
DriveSpace "DESKTOP-ABCDEF"
