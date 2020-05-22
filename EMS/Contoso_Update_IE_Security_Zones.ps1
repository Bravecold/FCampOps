﻿Function Add-XYLIETrustedZone {
    # Define the parameters passed to the script
    Param (
        [Parameter(Mandatory=$true,  HelpMessage="Registry Path")][String] $RegistryPath,
   
    $OriginalLocation = Get-Location

    if (!(Test-Path $($RegistryPath + "\" +$DomainName))){
        New-Item $DomainName
    }
    Set-Location $DomainName
    #if (!(Test-Path $($RegistryPath + "\" + $DomainName + "\" + $HostName))){
    #    New-Item $HostName
    #}

    #Set-Location $($RegistryPath + "\" + $DomainName + "\" + $HostName)
    New-ItemProperty . -Name https -Value 2 -Type DWORD

    Set-Location $OriginalLocation
}

# Get the current default location
$DomainName = "contoso.com"
$ADFSHost = "adfs"
$IntranetHost = "intranet"

# Set our default location to the registry path were trusted domains are located
$RegDomainsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains"
$RegEscDomainsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\EscDomains"

# Set the trusted domains for current user
# Add-XYLIETrustedZone -RegistryPath $RegDomainsPath -DomainName $DomainName -HostName $ADFSHost
# Add-XYLIETrustedZone -RegistryPath $RegDomainsPath -DomainName $DomainName -HostName $IntranetHost
Add-XYLIETrustedZone -RegistryPath $RegDomainsPath -DomainName $DomainName

# Set the trusted domains for Internet Enhanced Security (if running on a server operating system)
    # Add-XYLIETrustedZone -RegistryPath $RegEscDomainsPath -DomainName $DomainName -HostName $ADFSHost
    # Add-XYLIETrustedZone -RegistryPath $RegEscDomainsPath -DomainName $DomainName -HostName $IntranetHost
    Add-XYLIETrustedZone -RegistryPath $RegEscDomainsPath -DomainName $DomainName
}