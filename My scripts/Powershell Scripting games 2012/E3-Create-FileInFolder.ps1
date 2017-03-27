    <#
.SYNOPSIS

.DESCRIPTION
Create file with running processes in folder.
.PARAMETER EventFolder
Specifies the name of folder.
.EXAMPLE

    Create-FileInFolder.ps1 -EventFolder "2012SG\event3"

Creates the list of running processes in C:\2012SG\event3 folder
    
.NOTES
Author: Dzianis Sinevich
Version: 1.0.0
#>
    
[CmdletBinding()]

param
(
    [Parameter(Mandatory = $false)]
    [ValidateNotNullOrEmpty()]
    [string]
    $EventFolder = "2012SG\event3"
)

    try
    {
        if (-not(test-path "$env:SystemDrive\$EventFolder")) {
        New-Item -ItemType directory -Path "$env:SystemDrive\$EventFolder" -ErrorAction SilentlyContinue | Out-Null
        }

        Get-Process | Select-Object -Property @{Name = "Name"; Expression = {$_.ProcessName}}, Id | Out-File -FilePath $env:SystemDrive\$EventFolder\Process3.txt -Force
    
    }
    catch
    {
        New-Item -ItemType directory -Path $env:HOMEPATH\$EventFolder
        Get-Process | Select-Object -Property @{Name = "Name"; Expression = {$_.ProcessName}}, Id | Out-File -FilePath $env:HOMEPATH\$EventFolder\Process3.txt -Force
    }

