Get-Module  -ListAvailable PowerCLI* | Import-Module
Connect-VIServer  -Server 192.168.37.131 -User root -Password password
New-VM -Name 'TestVM4' -VMHost '192.168.37.131' -DiskGB 10 -MemoryGB 1 -NumCpu 1
