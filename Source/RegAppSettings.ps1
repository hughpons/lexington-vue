#Set-ExecutionPolicy Unrestricted -Scope CurrentUser

function SetKeyValue {
    param (
        [parameter(Mandatory=$true)]$Path,
        [parameter(Mandatory=$true)]$Name,
        [parameter(Mandatory=$true)]$Value
    )
    
    if (Test-Path -Path $Path) {
        Write-Output "$Path exists."
    }
    else {
        New-Item -Path $Path -Force | Out-Null
    }

    $r = (Get-Item -Path $Path -EA Ignore).Property -contains $Name
    if ($r) {
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force
    } else {
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType String -Force
    }
}

# Add database connection settings to the registry.
$ServerKey = "HKLM:\Software\LexingtonAcademy\Server"
SetKeyValue $ServerKey InstanceName local | Out-Null
SetKeyValue $ServerKey DatabaseName SchoolDB | Out-Null
