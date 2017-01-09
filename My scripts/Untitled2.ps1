param
(
    [Parameter(
        Mandatory = $false,
        HelpMessage = 'Specifies whether to copy generated .MOF and .CHECKSUM files to DSC Pull Servers.'
    )]
    [Switch]
    $Publish
)

Write-Host $PSBoundParameters.ContainsKey('Publish')
Write-Host $Publish.IsPresent


if ($PSBoundParameters.ContainsKey('Publish') -and $Publish.IsPresent)
{
    Write-Warning -Message 'The Publish switch parameter is present.'
    Write-Warning -Message 'Generated .MOF and .CHECKSUM files will be copied to DSC Pull Servers.'
}
else
{
    Write-Warning -Message 'The Publish switch parameter is not present.'
    Write-Warning -Message 'Run the following command to copy generated .MOF and .CHECKSUM files to DSC Pull Servers:'
    Write-Warning -Message ('& "{0}" -Publish' -f $PSCommandPath)
}
