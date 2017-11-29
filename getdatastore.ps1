#*************************************************************************************************************
#      Script Name	:   DataStoreFreeSpace-Percentage.ps1
#      Purpose		:   Get the report of datastores which has less than 20% free space.
#				
#      Date		:   24-11-2016	# - Initial version
#                   	:  
#      Author		:   www.VMwareArena.com
#
#*************************************************************************************************************
#
#$VCServer = Read-Host 'Enter VC Server name'
#$vcUSERNAME = Read-Host 'Enter user name'
#$vcPassword = Read-Host 'Enter password' -AsSecureString
#$vccredential = New-Object System.Management.Automation.PSCredential ($vcusername, $vcPassword)

Get-Module  -ListAvailable PowerCLI* | Import-Module
$LogFile = "DataStoreInfo_" + (Get-Date -UFormat "%d-%b-%Y-%H-%M") + ".csv" 

Write-Host "Connecting to $VCServer..." -Foregroundcolor "Yellow" -NoNewLine
$connection = Connect-VIServer -Server 192.168.37.131 -User root -Password password -ErrorAction SilentlyContinue -WarningAction 0 | Out-Null
If($? -Eq $True)

{
	Write-Host "Connected" -Foregroundcolor "Green" 
	$Results = @()
	$Result = Get-Datastore | Select @{N="DataStoreName";E={$_.Name}},@{N="Percentage Free Space(%)";E={[math]::Round(($_.FreeSpaceGB)/($_.CapacityGB)*100,2)}} | Where {$_."Percentage(&lt;20%)" -le 20}
	$Result | Export-Csv -NoTypeInformation $LogFile
        cat $LogFile
}
Else
{
	Write-Host "Error in Connecting to $VIServer; Try Again with correct user name &amp; password!" -Foregroundcolor "Red" 
}
Disconnect-VIServer * -Confirm:$false
#
#-------------------------------------------------------------------------------------------------------------
