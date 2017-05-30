function Get-ErrorEvents 
{
    [CmdletBinding()]
    param (

        [Parameter(Position=1, Mandatory=$false)]
        $OutputFile,
        
        [Parameter(Position=0, Mandatory=$false)]
        $ComputerName        
    )

    if ($ComputerName)
    {
        $result = Get-EventLog -LogName Application -EntryType Error -ComputerName $ComputerName | Group-Object Source | Select-Object -Property Count, Name | Sort-Object -Property Count -Descending
    }
    else
    {
        $result = Get-EventLog -LogName Application -EntryType Error | Group-Object Source | Select-Object -Property Count, Name | Sort-Object -Property Count -Descending
    }

    if ($OutputFile)
    {
        $result | Out-File -FilePath $OutputFile
    }
    else
    {
        Write-Output $result
    }


}

Get-ErrorEvents EPBYMINW5435