Function Get-Uptime {
<#
.SYNOPSIS 
        Displays Uptime since last reboot
.PARAMETER  Computername
.EXAMPLE
 Get-Uptime Server1
.EXAMPLE
 "Server1", "Server2"|Get-Uptime
.EXAMPLE
 (Get-Uptime Sever1)."Time Since Last Reboot"
#>
 [CmdletBinding()]
 Param (
 [Parameter(Mandatory=$True,ValueFromPipeline=$true,Position=0)]
        [STRING[]]$Computername
        )
 
 Begin {Write-Verbose "Version 1.00"}
        
 Process {
        $Now=Get-Date
        $LastBoot=[System.Management.ManagementDateTimeConverter]::ToDateTime((Get-WmiObject win32_operatingsystem -ComputerName $computername).lastbootuptime)
        $Result=@{ "Server"=$($Computername);
                   "Last Reboot"=$LastBoot;
                   "Time Since Reboot"="{0} Days {1} Hours {2} Minutes {3} Seconds" -f ($Now - $LastBoot).days, `
                        ($Now - $LastBoot).hours,($Now - $LastBoot).minutes,($Now - $LastBoot).seconds}
        Write-Output (New-Object psobject -Property $Result|select Server, "Last Reboot", "Time Since Reboot")
        }
}

