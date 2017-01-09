# Scripting Games 2012 Event 1
#
$computers = @('localhost', 'localhost')
foreach ($comp in $computers)
    {Write-Output $comp
    Get-Process | Sort-Object -Property PM -Descending | select -First 10
    }

Invoke-Command -ComputerName localhost, localhost -ScriptBlock {Get-Process | Sort-Object -Property WorkingSet -Descending | select -First 10}
#
# Scripting Games 2012 Event 2
Invoke-Command localhost  {Get-Service | where {$_.Status -eq 'Running' -and $_.CanStop}} # no need to search by service Status - CanStop property is $true, when service is running, and $false, when it is not.
gsv -ComputerName localhost | ? {$_.Status -eq 'Running' -and $_.CanStop} | gm
