<##########################################################################################################################################

Version :	0.1.1.0
Author  :	Gr33nDrag0n <gr33ndrag0n@lisknode.io> v0.1.1.0
History :	2016/05/17 - Release v0.1.1.0

##########################################################################################################################################>

$OldCulture = [System.Threading.Thread]::CurrentThread.CurrentUICulture
[System.Threading.Thread]::CurrentThread.CurrentUICulture = 'en-US'

##############################################################################

$CmdletName='Set-PsLiskConfiguration'
Get-Help $CmdletName -Full > ".\Documentation\$CmdletName.txt"

#-----------------------------------------------------------------------------

$CmdletName='Get-PsLiskAccount'
Get-Help $CmdletName -Full > ".\Documentation\$CmdletName.txt"

$CmdletName='Get-PsLiskAccountBalance'
Get-Help $CmdletName -Full > ".\Documentation\$CmdletName.txt"

$CmdletName='Get-PsLiskAccountPublicKey'
Get-Help $CmdletName -Full > ".\Documentation\$CmdletName.txt"

$CmdletName='Get-PsLiskAccountVote'
Get-Help $CmdletName -Full > ".\Documentation\$CmdletName.txt"

$CmdletName='New-PsLiskAccount'
Get-Help $CmdletName -Full > ".\Documentation\$CmdletName.txt"

$CmdletName='Open-PsLiskAccount'
Get-Help $CmdletName -Full > ".\Documentation\$CmdletName.txt"

#-----------------------------------------------------------------------------

#$CmdletName=''
#Get-Help $CmdletName -Full > ".\Documentation\$CmdletName.txt"

##############################################################################

[System.Threading.Thread]::CurrentThread.CurrentUICulture = $OldCulture
