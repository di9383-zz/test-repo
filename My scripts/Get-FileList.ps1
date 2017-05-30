function Get-FileList
{
    [CmdletBinding()]
    param 
    (

    [string]
    $Path = 'C:\OCCM\Harbor\Websites\HarborSys.com-STAGE1',

    [Parameter(Mandatory = $false)]
    $FilesToExclude
      
    ) 

#    $FilesList = Get-ChildItem -Path $Path -Exclude $FilesToExclude -File -Recurse
#    $FileNumber = (Get-ChildItem -Path $Path -Exclude $FilesToExclude -File -Recurse).count
#    Write-Output $FilesList $FileNumber
    $basepath = (Get-Item $Path).Parent.FullName

    $FilesList = Get-ChildItem -Path $Path -Exclude $FilesToExclude -File -Recurse
    $FilesList = $FilesList | Select-Object @{Name = "Directory";Expression = {$_.Directory.FullName.Substring($path.Length)}},
                                            @{Name = "FileName";Expression = {$_.Name}},
                                            @{Name = "FileSize(Bytes)";Expression = {'{0:N0}' -f $_.Length}},
                                            @{Name="FileHash";Expression = {(Get-FileHash $_).Hash}}
    $FilesList = $FilesList | sort Directory, FileName
    Write-Output $FilesList | Format-Table -AutoSize -Wrap  | Out-File 'C:\Users\dsinevich\list.txt'
    Write-Output ('Total files {0}' -f $FilesList.Count)
}

Get-FileList -Path C:\OCCM\Harbor\Websites\HarborSys.com-STAGE1 -FilesToExclude *.cs, *.bak
