<##########################################################################################################################################

Version :	0.2.0.0
Author  :	Gr33nDrag0n <gr33ndrag0n@lisknode.io> v0.1.1.0 - v0.2.0.0
History :	2016/11/26 - Release v0.2.0.0
          2016/05/17 - Release v0.1.1.0

##########################################################################################################################################>


# Add Param: -Config
# Add Param: -NodeList
# Add Param: -NoBanner

Clear-Host

###########################################################################################################################################
#### Config File Verification

# Test Path
#if( Test-Path 

# Load in memory
$Private:MyConfig = Get-Content .\Config-Gr33nDrag0n.json | ConvertFrom-Json

# Test Required Account Values


$Private:MyAccount = $MyConfig.Account
Write-Host '#### Accounts #################################################################'
$MyAccount

###########################################################################################################################################


$Private:MyServerList = $MyConfig.Servers
Write-Host '#### ServerList ###############################################################'
$MyServerList

###########################################################################################################################################
#### Module Verification

# If module already in memory, remove it from memory. (Faster Dev.)
if( Get-Module -Name PsLisk ) { Remove-Module PsLisk }

# Load PsLisk module.
if( Get-Module -ListAvailable | Where-Object { $_.Name -eq 'PsLisk' } )
{
	#Import-Module PsLisk –DisableNameChecking
	Import-Module PsLisk
	Write-Host 'PsLisk Module Loaded' -Foreground Green
}
else
{   
	Write-Host 'PsLisk Module Not Found' -Foreground Red
	Exit
}


###########################################################################################################################################
#### Show Banner

Show-PsLiskAbout

#### Configure API Server

Write-Host 'Set-PsLiskConfiguration -URI "https://login.lisk.io/api/"' -Foreground Cyan
Set-PsLiskConfiguration -URI $MyServerList[0]
Write-Host ''

#### API Call: Accounts

Write-Host 'Get-PsLiskAccount -Address $Address' -Foreground Cyan
Get-PsLiskAccount -Address $MyAccount.DelegateAddress | FL *

Write-Host 'Get-PsLiskAccountBalance -Address $Address' -Foreground Cyan
Get-PsLiskAccountBalance -Address $MyAccount.DelegateAddress | FL *

Write-Host 'Get-PsLiskAccountPublicKey -Address $Address' -Foreground Cyan
Write-Host ''
Get-PsLiskAccountPublicKey -Address $MyAccount.DelegateAddress
Write-Host ''

Write-Host 'Get-PsLiskAccountVote -Address $Address' -Foreground Cyan
Get-PsLiskAccountVote -Address $MyAccount.DelegateAddress | FL *

Write-Host "New-PsLiskAccount -Secret 'New Account Password'" -Foreground Cyan
New-PsLiskAccount -Secret 'New Account Password' | FL *

Write-Host 'Open-PsLiskAccount -Secret $Secret' -Foreground Cyan
Open-PsLiskAccount -Secret $MyAccount.DelegateSecret | FL *

#Write-Host 'Add-PsLiskAccountVote ???'
#Add-PsLiskAccountVote | FT

#Write-Host 'Remove-PsLiskAccountVote ???'
#Remove-PsLiskAccountVote | FT

#### API Call: Loader

Write-Host 'Get-PsLiskLoadingStatus' -Foreground Cyan
Get-PsLiskLoadingStatus | FL *

Write-Host 'Get-PsLiskSyncStatus' -Foreground Cyan
Get-PsLiskSyncStatus | FL *