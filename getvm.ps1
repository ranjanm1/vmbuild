Get-Module  -ListAvailable PowerCLI* | Import-Module

Connect-VIServer  -Server 192.168.37.131 -User root -Password password

Get-VMHost

Get-VM | Select  Name,VMHost, PowerState, MemoryGB
