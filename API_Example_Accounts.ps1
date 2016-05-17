<##########################################################################################################################################

Version :	0.1.1.0
Author  :	Gr33nDrag0n <gr33ndrag0n@lisknode.io> v0.1.0.0 - v0.1.1.0
History :	2016/05/16 - Release v0.1.1.0
			2016/05/02 - Release v0.1.0.1
			2016/04/10 - Release v0.1.0.0
			2016/04/08 - Creation of the module.

Reference:	https://github.com/LiskHQ/lisk-docs/blob/master/APIReference.md
			https://lisk.io/documentation?i=lisk-docs/APIReference

##########################################################################################################################################>

Clear-Host

$Private:MyConfig = Get-Content .\PsLiskConfig.json | ConvertFrom-Json
$Private:MyAccount = $MyConfig.Account
$Private:MyServerList = $MyConfig.Servers

if( Get-Module -Name PsLisk ) { Remove-Module PsLisk }

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

#### Show Banner

Show-PsLiskAbout

#### Configure API Server

Write-Host 'Set-PsLiskConfiguration -URI "https://login.lisk.io/api/"' -Foreground Cyan
Set-PsLiskConfiguration -URI $MyServerList[3]
Write-Host ''

#### API Call: Accounts

Write-Host 'Get-PsLiskAccount -Address $Address' -Foreground Cyan
Get-PsLiskAccount -Address $MyAccount.Address | FL *

Write-Host 'Get-PsLiskAccountBalance -Address $Address' -Foreground Cyan
Get-PsLiskAccountBalance -Address $MyAccount.Address | FL *

Write-Host 'Get-PsLiskAccountPublicKey -Address $Address' -Foreground Cyan
Write-Host ''
Get-PsLiskAccountPublicKey -Address $MyAccount.Address
Write-Host ''

Write-Host 'Get-PsLiskAccountVote -Address $Address' -Foreground Cyan
Get-PsLiskAccountVote -Address $MyAccount.Address | FL *

Write-Host "New-PsLiskAccount -Secret 'New Account Password'" -Foreground Cyan
New-PsLiskAccount -Secret 'New Account Password' | FL *

Write-Host 'Open-PsLiskAccount -Secret $Secret' -Foreground Cyan
Open-PsLiskAccount -Secret $MyAccount.Secret | FL *

#Write-Host 'Add-PsLiskAccountVote ???'
#Add-PsLiskAccountVote | FT

#Write-Host 'Remove-PsLiskAccountVote ???'
#Remove-PsLiskAccountVote | FT
