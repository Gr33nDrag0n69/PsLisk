<##########################################################################################################################################

Version :	0.1.1.0
Author  :	Gr33nDrag0n <gr33ndrag0n@lisknode.io> v0.1.0.0 - v0.1.1.0
History :	2016/05/14 - Release v0.1.1.0
			2016/05/02 - Release v0.1.0.1
			2016/04/10 - Release v0.1.0.0
			2016/04/08 - Creation of the module.

Reference:	https://github.com/LiskHQ/lisk-docs/blob/master/APIReference.md
			https://lisk.io/documentation?i=lisk-docs/APIReference

#### PsLisk Configuration ###########################################################

Set-PsLiskConfiguration						v0.1.1.0 + Help

#### API Call Functions #############################################################

# Accounts #-------------------------------------------------------------------------

Get-PsLiskAccountsDelegates					v0.1.1.0 + Help

Get-PsLiskAccountBalance					N/A (Priority 6)
Get-PsLiskAccountPublickey					N/A (Priority 10) ( Integrate Generate public key ? )
Get-PsLiskAccount							N/A (Priority 10)
Get-PsLiskAccountDelegate					N/A (Priority 10)

Open-PsLiskAccount							N/A (Priority 10)
Vote-PsLiskDelegate							N/A (Priority 10)

# Loader #---------------------------------------------------------------------------

Get-PsLiskLoadingStatus						N/A (Priority 3)
Get-PsLiskSyncStatus						N/A (Priority 3)

# Transactions #---------------------------------------------------------------------

Get-PsLiskTransaction						N/A (Priority 3)
Get-PsLiskTransactionList					N/A (Priority 5)
Get-PsLiskTransactionUnconfirmed			N/A (Priority 3)
Get-PsLiskTransactionUnconfirmedList		N/A (Priority 3)

Send-PsLiskTransaction						N/A (Priority 5)

# Peers #----------------------------------------------------------------------------

Get-PsLiskPeer								N/A (Priority 10)
Get-PsLiskPeerList							N/A (Priority 10)
Get-PsLiskPeerListVersion					N/A (Priority 10)

# Blocks #---------------------------------------------------------------------------

Get-PsLiskBlock								N/A (Priority 5)
Get-PsLiskBlockList							N/A (Priority 5)
Get-PsLiskBlockFee							N/A (Priority 5)
Get-PsLiskBlockHeight						N/A (Priority 5)
Get-PsLiskBlockForged						N/A (Priority 5)

# Signatures #-----------------------------------------------------------------------

Get-PsLiskSignature							N/A (Priority 3)

Add-PsLiskSecondSignature					N/A (Priority 3)

# Delegates #------------------------------------------------------------------------

Get-PsLiskDelegate							N/A (Priority 8)
Get-PsLiskDelegateList						N/A (Priority 8)
Get-PsLiskDelegateVoterList					N/A (Priority 8)

Enable-PsLiskDelegate						N/A (Priority 8)
Enable-PsLiskDelegateForging				N/A (Priority 8)
Disable-PsLiskDelegateForging				N/A (Priority 8)

# Messages #-------------------------------------------------------------------------

Send-PsLiskMessage							N/A (Priority 3)

# Usernames #------------------------------------------------------------------------

Register-PsLiskUsername						N/A (Priority 0, Deprecated)

# Dapps #----------------------------------------------------------------------------

Get-PsLiskDappInstalledList					N/A (Priority 3)
Get-PsLiskDappInstalledListByIds			N/A (Priority 3)

Register-PsLiskDapp							N/A (Priority 3)

Search-PsLiskDappStore						N/A (Priority 3)
Install-PsLiskDapp							N/A (Priority 3)
Uninstall-PsLiskDapp						N/A (Priority 3)

Start-PsLiskDapp							N/A (Priority 3)
Stop-PsLiskDapp								N/A (Priority 3)

# Multi-Signature #------------------------------------------------------------------

Get-PsLiskMultiSigPendingTransactionList	N/A (Priority 3)
Get-PsLiskMultiSigAccountList				N/A (Priority 3)

New-PsLiskMultiSigAccount					N/A (Priority 3)
Sign-PsLiskMultiSigTransaction				N/A (Priority 3)

#### Internal Functions #############################################################

Invoke-PsLiskApiCall						v0.l.1.0

#### Misc. Functions ################################################################

# Usage Ideas
Send-PsLiskMultiTransaction	-NbPerBlock 2 -NbBlock 5 -ToAddress -FromAddress -FromPassphrase  -FromSecondPassphrase

Show-PsLiskDelegateUsername					N/A (Priority 9)
Start-PsLiskNetworkMonitor					N/A (Priority 3)

Show-PsLiskAbout							v0.l.0.0

##########################################################################################################################################>

$Script:PsLisk_URI = 'https://testnet.lisk.io/api/'
$Script:PsLisk_Address = '10829835517993670808L'
$Script:PsLisk_PublicKey = ''
$Script:PsLisk_Passphrase = ''

##########################################################################################################################################################################################################
### PsLisk Configuration
##########################################################################################################################################################################################################

<#
.SYNOPSIS
	Set Default Parameters
	
.DESCRIPTION
	Use this function to define your own default value.
	
.PARAMETER URI
	(Optional) URL for Lisk API request. Try to use HTTPS if possible.

.PARAMETER Address
	(Optional) Account Address.
	Note: Default Public Key will also be updated.
	
.PARAMETER Passphrase
	(Optional) Account Passphrase.
	
.EXAMPLE
	Set-PsLiskConfiguration -URI https://login.lisk.io/api/

.EXAMPLE
	Set-PsLiskConfiguration -URI https://login.lisk.io/api/ -Address 10829835517993670808L

.EXAMPLE
	Set-PsLiskConfiguration -Address 17674416850039139965L -Passphrase 'soon control wild distance sponsor decrease cheap example avoid route ten pudding'
#>

Function Set-PsLiskConfiguration
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $False)] [string] $URI,
		[parameter(Mandatory = $False)] [string] $Address='',
		[parameter(Mandatory = $False)] [string] $Passphrase=''
        )
		
	if( $URI -ne '' )
	{
		$Script:PsLisk_URI = $URI
	}
	
	if( $Address -ne '' )
	{
		$Script:PsLisk_Address = $Address
		$Script:PsLisk_PublicKey = $Address
	}
	
	if( $Passphrase -ne '' )
	{
		$Script:PsLisk_Passphrase = $Passphrase
	}
}

##########################################################################################################################################################################################################
### API Call: Accounts
##########################################################################################################################################################################################################

<#
.SYNOPSIS
	API Call: Get votes by account address.
	
.DESCRIPTION
	Return an Array of the votes for a given address.
	
.PARAMETER Address

.EXAMPLE
	Get-PsLiskAccountsDelegates -Address 10829835517993670808L
#>

Function Get-PsLiskAccountsDelegates
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $Address
        )
	
	$Private:Output = Invoke-PsLiskApiCall -URI $( $Script:PsLisk_URI+'accounts/delegates/?address='+$Address )
	if( $Output.success -eq $True ) { $Output.delegates }
}

<#
Get-PsLiskAccountBalance					N/A (Priority 6)
Get-PsLiskAccountPublickey					N/A (Priority 10) ( Integrate Generate public key ? )
Get-PsLiskAccount							N/A (Priority 10)
Get-PsLiskAccountDelegate					N/A (Priority 10)

Open-PsLiskAccount							N/A (Priority 10)
Vote-PsLiskDelegate							N/A (Priority 10)
#>

##########################################################################################################################################################################################################
### API Call: Loader
##########################################################################################################################################################################################################

<#
Get-PsLiskLoadingStatus						N/A (Priority 3)
Get-PsLiskSyncStatus						N/A (Priority 3)
#>

##########################################################################################################################################################################################################
### API Call: Transactions
##########################################################################################################################################################################################################

<#
Get-PsLiskTransaction						N/A (Priority 3)
Get-PsLiskTransactionList					N/A (Priority 5)
Get-PsLiskTransactionUnconfirmed			N/A (Priority 3)
Get-PsLiskTransactionUnconfirmedList		N/A (Priority 3)

Send-PsLiskTransaction						N/A (Priority 5)
#>

##########################################################################################################################################################################################################
### API Call: Peers
##########################################################################################################################################################################################################

<#
Function Get-PsLiskPeer
{
	$Private:Output = Invoke-PsLiskApiCall -URI $( $Script:PsLisk_URI+'peers' )
	if( $Output.success -eq $True ) { $Output.peers }
}
#>

<#
Get-PsLiskPeer								N/A (Priority 10)
Get-PsLiskPeerList							N/A (Priority 10)
Get-PsLiskPeerListVersion					N/A (Priority 10)
#>

##########################################################################################################################################################################################################
### API Call: Blocks
##########################################################################################################################################################################################################

<#
Get-PsLiskBlock								N/A (Priority 5)
Get-PsLiskBlockList							N/A (Priority 5)
Get-PsLiskBlockFee							N/A (Priority 5)
Get-PsLiskBlockHeight						N/A (Priority 5)
Get-PsLiskBlockForged						N/A (Priority 5)
#>

##########################################################################################################################################################################################################
### API Call: Signatures
##########################################################################################################################################################################################################

<#
Get-PsLiskSignature							N/A (Priority 3)

Add-PsLiskSecondSignature					N/A (Priority 3)
#>

##########################################################################################################################################################################################################
### API Call: Delegates
##########################################################################################################################################################################################################

<#
Get-PsLiskDelegate							N/A (Priority 8)
Get-PsLiskDelegateList						N/A (Priority 8)
Get-PsLiskDelegateVoterList					N/A (Priority 8)

Enable-PsLiskDelegate						N/A (Priority 8)
Enable-PsLiskDelegateForging				N/A (Priority 8)
Disable-PsLiskDelegateForging				N/A (Priority 8)
#>

##########################################################################################################################################################################################################
### API Call: Messages
##########################################################################################################################################################################################################

<#
Send-PsLiskMessage							N/A (Priority 3)
#>

##########################################################################################################################################################################################################
### API Call: Usernames
##########################################################################################################################################################################################################

<#
Register-PsLiskUsername						N/A (Priority 0, Deprecated)
#>

##########################################################################################################################################################################################################
### API Call: Dapps
##########################################################################################################################################################################################################

<#
Get-PsLiskDappInstalledList					N/A (Priority 3)
Get-PsLiskDappInstalledListByIds			N/A (Priority 3)

Register-PsLiskDapp							N/A (Priority 3)

Search-PsLiskDappStore						N/A (Priority 3)
Install-PsLiskDapp							N/A (Priority 3)
Uninstall-PsLiskDapp						N/A (Priority 3)

Start-PsLiskDapp							N/A (Priority 3)
Stop-PsLiskDapp								N/A (Priority 3)
#>

##########################################################################################################################################################################################################
### API Call: Multi-Signature
##########################################################################################################################################################################################################

<#
Get-PsLiskMultiSigPendingTransactionList	N/A (Priority 3)
Get-PsLiskMultiSigAccountList				N/A (Priority 3)

New-PsLiskMultiSigAccount					N/A (Priority 3)
Sign-PsLiskMultiSigTransaction				N/A (Priority 3)
#>

##########################################################################################################################################################################################################
### Internal Functions
##########################################################################################################################################################################################################

Function Invoke-PsLiskApiCall
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $URI
        )
		
	Write-Verbose "Invoke-PsLiskApiCall => $URI"
	$Private:WebRequest = Invoke-WebRequest -Uri $URI

	if( ( $WebRequest.StatusCode -eq 200 ) -and ( $WebRequest.StatusDescription -eq 'OK' ) )
	{
		$Private:Result = $WebRequest | ConvertFrom-Json
		if( $Result.success -eq $True ) { $Result }
		else { Write-Warning "Invoke-PsLiskApiCall | success => false | error => $($Result.error)" }
	}
	else { Write-Warning "Invoke-PsLiskApiCall | WebRequest returned Status '$($WebRequest.StatusCode) $($WebRequest.StatusDescription)'." }
}

##########################################################################################################################################################################################################
### Miscellaneous
##########################################################################################################################################################################################################

<#
.SYNOPSIS
	Misc. Tool: Get Colored Delegate Username
	
.DESCRIPTION
	Output colored delegate name of voted delegate for a given address.
	
	Green  => Delegate is voting back.
	Yellow => Delegate is NOT voting back.
	
	A delegate address might not vote for your delegate (yellow) but the owner is using another address not linked to is delagate account.
	
.PARAMETER Address

.EXAMPLE
	Get-PsLiskDelegate -Address 18425916700658032295L
#>
<#
Function Show-PsLiskDelegateUsername
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $Address=''
        )
	
	$Private:MainAddressVoteList = Get-PsLiskDelegate -Address $Address
	$Private:MainAddressVoteList_Count = $MainAddressVoteList | Measure-Object | Select-Object -ExpandProperty Count
	Write-Host ''
	Write-Host "Address '$Address' is currently voting for $MainAddressVoteList_Count delegates."
	$Private:Count = 0
	
	ForEach( $Private:MainAddressVote in $MainAddressVoteList )
	{
		$Count++
		$Private:VotedAddressVoteList = Get-PsLiskDelegate -Address $MainAddressVote.address
		
		if( ( $VotedAddressVoteList | Where-Object { $_.address -eq $Address } ) -ne $NULL )
		{
			Write-Host $MainAddressVote.username -ForegroundColor Green -NoNewLine
		}
		else
		{
			Write-Host $MainAddressVote.username -ForegroundColor Yellow -NoNewLine
		}
		
		if( $Count -lt $MainAddressVoteList_Count ) { Write-Host ', ' -NoNewLine }
	}
	Write-Host ''
	Write-Host ''
}
#>
##########################################################################################################################################################################################################

# Inspired by lisk-network-monitor made by fix (fixcrypt)
<#
Function Start-PsLiskNetworkMonitor
{

	$Private:Peers = Get-PsLiskPeer
	#$Peers | FT
	
	$Private:Peers_Count_Total = $Peers | Measure-Object | Select-Object -ExpandProperty Count
	
	$Private:Peers_Count_Banned = $Peers | Where-Object { $_.state -eq 0 } | Measure-Object | Select-Object -ExpandProperty Count
	$Private:Peers_Count_Disconnected = $Peers | Where-Object { $_.state -eq 1 } | Measure-Object | Select-Object -ExpandProperty Count
	$Private:Peers_Count_Connected = $Peers | Where-Object { $_.state -eq 2 } | Measure-Object | Select-Object -ExpandProperty Count
	
	
	$Private:Peers_000 = $Peers | Where-Object { ( $_.version -ne '0.1.1' ) -and ( $_.version -ne '0.1.2' ) -and ( $_.version -ne '0.1.3' ) }
	$Private:Peers_Count_000 = $Peers_000 | Measure-Object | Select-Object -ExpandProperty Count
	$Private:Peers_Count_011 = $Peers | Where-Object { $_.version -eq '0.1.1' } | Measure-Object | Select-Object -ExpandProperty Count
	$Private:Peers_Count_012 = $Peers | Where-Object { $_.version -eq '0.1.2' } | Measure-Object | Select-Object -ExpandProperty Count
	$Private:Peers_Count_013 = $Peers | Where-Object { $_.version -eq '0.1.3' } | Measure-Object | Select-Object -ExpandProperty Count
	
	Write-Host ''
	Write-Host "Peers Count          => $Peers_Count_Total"
	Write-Host ''
	Write-Host "Peers Connected      => $Peers_Count_Connected"
	Write-Host "Peers Disconnected   => $Peers_Count_Disconnected"
	Write-Host "Peers Banned         => $Peers_Count_Banned"
	Write-Host ''
	Write-Host "Peers v0.1.1         => $Peers_Count_011"
	Write-Host "Peers v0.1.2         => $Peers_Count_012"
	Write-Host "Peers v0.1.3         => $Peers_Count_013"
	Write-Host "Peers v?.?.?         => $Peers_Count_000"
	$Peers_000 | FT

	
ip              port state os                            sharePort version
--              ---- ----- --                            --------- -------
83.136.249.126  7000     2 linux3.13.0-83-generic                1 0.1.2
45.32.236.171   7000     2 linux3.13.0-85-generic                1 0.1.2
104.156.254.116 7000     2 linux3.13.0-85-generic                1 0.1.2
108.61.190.139  7000     2 linux3.13.0-83-generic                1 0.1.2
104.238.170.122 7000     2 linux3.13.0-85-generic                1 0.1.2
40.118.167.63      1     1 linux3.2.0-4-amd64                    0 0.1.1

      function checkPeers(){
        window.syncdata=[];
        $.get("https://login.lisk.io/api/peers").success(function(data){
          data.peers.forEach(function(peer){
            $.get("http://"+peer.ip+":"+peer.port+"/api/loader/status/sync").success(function(data2){
              data2.ip=peer.ip;
              window.syncdata.push(data2);
            });
          });
        });
        $.get("https://login.lisk.io/api/loader/status/sync").success(function(data2){
          data2.ip="<span class='text-danger'>login.lisk.io</span>";
          window.syncdata.push(data2);
        });
        setTimeout(function(){
          displayPeers();
          checkPeers();
        }, 10000);
      }
	  
      function checkPeers(){
        window.syncdata=[];
        $.get("https://login.lisk.io/api/peers").success(function(data){
          data.peers.forEach(function(peer){
            $.get("http://"+peer.ip+":"+peer.port+"/api/loader/status/sync").success(function(data2){
              data2.ip=peer.ip;
              window.syncdata.push(data2);
            });
          });
        });
        $.get("https://login.lisk.io/api/loader/status/sync").success(function(data2){
          data2.ip="<span class='text-danger'>login.lisk.io</span>";
          window.syncdata.push(data2);
        });
        setTimeout(function(){
          displayPeers();
          checkPeers();
        }, 20000);

}
#>

##########################################################################################################################################################################################################

Function Show-PsLiskAbout
{
	Write-Host ''
	ForEach( $Private:Line in Get-Content $( $PSScriptRoot + '\About.txt' ) ) 
	{
		Write-Host $Line -ForegroundColor Green
	}
	Write-Host ''
	Write-Host '    Lisk   | Decentralized Application Platform. | https://lisk.io/'
	Write-Host '    PSLisk | PowerShell Module for Lisk API.     | https://git.lisknode.io/PsLisk/'
	Write-Host ''
}

##########################################################################################################################################################################################################
