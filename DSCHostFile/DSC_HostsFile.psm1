function Test-TargetResource
{
    [OutputType([boolean])]
    param (
        [parameter(Mandatory)]
        [string]
        $HostName,
        [parameter(Mandatory)]
        [string]
        $IPAddress,
        [ValidateSet('Present','Absent')]
        [string]
        $Ensure = 'Present'
    )

try {
    Write-Verbose "Checking if the hosts file entry exists or not"
    $entryExist = ((Get-Content "${env:windir}\system32\drivers\etc\hosts" -ErrorAction Stop) -match "^[^#]*$ipAddress\s+$hostName")

    if ($Ensure -eq "Present") {
        if ($entryExist) {
            Write-Verbose "Hosts file entry exists for the given parameters; nothing to configure."
            return $true
        } else {
            Write-Verbose "Hosts file does not exist while it should; it will be added."
            return $false
        }
    } else {
        if ($entryExist) {
            Write-Verbose "Hosts file entry exists while it should not; it must be removed."
            return $false
        } else {
            Write-Verbose "Hosts file entry does not exist; nothing to configure."
            return $true
        }
    }
}

catch {
    $exception = $_
    Write-Verbose "Error occurred while executing Test-TargetResource function"
    while ($exception.InnerException -ne $null)
        {
            $exception = $exception.InnerException
            Write-Verbose $exception.message
        }
    }
}

function Set-TargetResource
{
    param (
        [parameter(Mandatory)]
        [string]
        $HostName,
        [parameter(Mandatory)]
        [string]
        $IPAddress,
        [ValidateSet('Present','Absent')]
        [string]
        $Ensure = 'Present'
    )

$hostEntry = "`n${ipAddress}`t${hostName}"
$hostsFilePath = "${env:windir}\system32\drivers\etc\hosts"

try {
    if ($Ensure -eq 'Present')
    {
        Write-Verbose "Creating hosts file entry '$hostEntry'"
        Add-Content –Path $hostsFilePath Value $hostEntry -Force -Encoding ASCII –ErrorAction Stop
        Write-Verbose "Hosts file entry '$hostEntry' added"
    }
    else
    {
        Write-Verbose "Removing hosts file entry '$hostEntry'"
        ((Get-Content $hostsFilePath) -notmatch "^\s*$") -notmatch "^[^#]*$ipAddress\s+$hostName" | Set-Content $hostsFilePath
        Write-Verbose "Hosts file entry '$hostEntry' removed"
    }
}
catch {
        $exception = $_
        Write-Verbose "An error occurred while running Set-TargetResource function"
        while ($exception.InnerException -ne $null)
        {
            $exception = $exception.InnerException
            Write-Verbose $exception.message
        }
      }
}

function Get-TargetResource
{
    [OutputType([Hashtable])]
    param (
        [parameter(Mandatory]
        [string]
        $HostName,
        [parameter(Mandatory)]
        [string]
        $IPAddress
    )

$Configuration = @{
    HostName = $hostName
    IPAddress = $IPAddress
}

Write-Verbose "Checking if hosts file entry exists or not"
try {
    if ((Get-Content "${env:windir}\system32\drivers\etc\hosts" -ErrorAction SilentlyContinue) -match "^[^#]*$ipAddress\s+$hostName") {
        Write-Verbose "Hosts file entry does exists"
        $Configuration.Add('Ensure','Present')
    } else {
        Write-Verbose "Hosts file entry does not exist"
        $Configuration.Add('Ensure','Absent')
    }
    return $Configuration
}
catch {
    $exception = $_
    Write-Verbose "Error occurred while running Get-TargetResource function"
    while ($exception.InnerException -ne $null)
        {
            $exception = $exception.InnerException
            Write-Verbose $exception.message
        }
    }
}

Export-ModuleMember -Function *-TargetResource