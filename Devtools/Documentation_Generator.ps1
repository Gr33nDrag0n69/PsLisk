<##########################################################################################################################################

Version :	0.2.0.0
Author  :	Gr33nDrag0n <gr33ndrag0n@lisknode.io> v0.1.1.0 - v0.2.0.0
History :	2016/11/26 - Release v0.2.0.0
          2016/05/17 - Release v0.1.1.0

##########################################################################################################################################>

# Patch to generate documentation in english
$OldCulture = [System.Threading.Thread]::CurrentThread.CurrentUICulture
[System.Threading.Thread]::CurrentThread.CurrentUICulture = 'en-US'

##############################################################################

$CmdletName='Set-PsLiskConfiguration'
Get-Help $CmdletName -Full > "..\Documentation\$CmdletName.txt"

#-----------------------------------------------------------------------------

$CmdletName='Get-PsLiskAccount'
Get-Help $CmdletName -Full > "..\Documentation\$CmdletName.txt"

$CmdletName='Get-PsLiskAccountBalance'
Get-Help $CmdletName -Full > "..\Documentation\$CmdletName.txt"

$CmdletName='Get-PsLiskAccountPublicKey'
Get-Help $CmdletName -Full > "..\Documentation\$CmdletName.txt"

$CmdletName='Get-PsLiskAccountVote'
Get-Help $CmdletName -Full > "..\Documentation\$CmdletName.txt"

$CmdletName='New-PsLiskAccount'
Get-Help $CmdletName -Full > "..\Documentation\$CmdletName.txt"

$CmdletName='Open-PsLiskAccount'
Get-Help $CmdletName -Full > "..\Documentation\$CmdletName.txt"

#-----------------------------------------------------------------------------

#$CmdletName=''
#Get-Help $CmdletName -Full > "..\Documentation\$CmdletName.txt"

##############################################################################

# Restore local default
[System.Threading.Thread]::CurrentThread.CurrentUICulture = $OldCulture
