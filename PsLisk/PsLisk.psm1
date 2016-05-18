<##########################################################################################################################################

Version :	0.1.1.0
Author  :	Gr33nDrag0n <gr33ndrag0n@lisknode.io> v0.1.0.0 - v0.1.1.0
History :	2016/05/17 - Release v0.1.1.0
			2016/05/02 - Release v0.1.0.1
			2016/04/10 - Release v0.1.0.0
			2016/04/08 - Creation of the module.

Reference:	https://github.com/LiskHQ/lisk-docs/blob/master/APIReference.md
			https://lisk.io/documentation?i=lisk-docs/APIReference

#### PsLisk Configuration ###########################################################

Set-PsLiskConfiguration						v0.1.1.0 + Help

#### API Call Functions #############################################################

# Accounts #-------------------------------------------------------------------------

Get-PsLiskAccount							v0.1.1.0 + Help
Get-PsLiskAccountBalance					v0.1.1.0 + Help
Get-PsLiskAccountPublicKey					v0.1.1.0 + Help
Get-PsLiskAccountVote						v0.1.1.0 + Help
Get-PsLiskAccountSecondSignature			Struct Only

New-PsLiskAccount							v0.1.1.0 (Partial) + Help
Open-PsLiskAccount							v0.1.1.0 + Help
Add-PsLiskAccountVote						Struct Only
Remove-PsLiskAccountVote					Struct Only
Add-PsLiskAccountSecondSignature			Struct Only

# Loader #---------------------------------------------------------------------------

Get-PsLiskLoadingStatus						Struct Only
Get-PsLiskSyncStatus						Struct Only

# Transactions #---------------------------------------------------------------------

Get-PsLiskTransaction						Struct Only
Get-PsLiskTransactionList					Struct Only
Get-PsLiskTransactionUnconfirmed			Struct Only
Get-PsLiskTransactionUnconfirmedList		Struct Only

Send-PsLiskTransaction						Struct Only

# Peers #----------------------------------------------------------------------------

Get-PsLiskPeer								Struct Only
Get-PsLiskPeerList							Struct Only
Get-PsLiskPeerListVersion					Struct Only

# Blocks #---------------------------------------------------------------------------

Get-PsLiskBlock								Struct Only
Get-PsLiskBlockList							Struct Only
Get-PsLiskBlockFee							Struct Only
Get-PsLiskBlockHeight						Struct Only
Get-PsLiskBlockForged						Struct Only

# Delegates #------------------------------------------------------------------------

Get-PsLiskDelegate							Struct Only
Get-PsLiskDelegateList						Struct Only
Get-PsLiskDelegateVoterList					Struct Only

Enable-PsLiskDelegate						Struct Only
Or
New-PsLiskDelegate							Struct Only

Enable-PsLiskDelegateForging				Struct Only
Disable-PsLiskDelegateForging				Struct Only

# Multi-Signature #------------------------------------------------------------------

Get-PsLiskMultiSigPendingTransactionList	N/A (Priority 3)
Get-PsLiskMultiSigAccountList				N/A (Priority 3)

New-PsLiskMultiSigAccount					N/A (Priority 3)
Sign-PsLiskMultiSigTransaction				N/A (Priority 3)

#### Internal Functions #############################################################

Invoke-PsLiskApiCall						v0.l.1.0
Export-PsLiskCsv							N/A (Priority 5)
Export-PsLiskJson							N/A (Priority 5)

#### Misc. Functions ################################################################

# Usage Ideas
Send-PsLiskMultiTransaction	-NbPerBlock 2 -NbBlock 5 -ToAddress -FromAddress -FromPassphrase  -FromSecondPassphrase

Show-PsLiskDelegateUsername					N/A (Priority 9)
Start-PsLiskNetworkMonitor					N/A (Priority 3)

Show-PsLiskAbout							v0.l.0.0

##########################################################################################################################################>

$Script:PsLisk_URI = 'https://testnet.lisk.io/api/'

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
        [parameter(Mandatory = $True)] [string] $URI
        )
		
	$Script:PsLisk_URI = $URI
}

##########################################################################################################################################################################################################
### API Call: Accounts
##########################################################################################################################################################################################################

<#
.SYNOPSIS
	API Call: Get informations about an account from address.
	
.DESCRIPTION
	Return an object with following properties:
	
    "address": "Address of account. String",
    "unconfirmedBalance": "Unconfirmed balance of account. Integer",
    "balance": "Balance of account. Integer",
    "publicKey": "Public key of account. Hex",
    "unconfirmedSignature": "If account enabled second signature, but it's still not confirmed. Boolean: true or false",
    "secondSignature": "If account enabled second signature. Boolean: true or false",
    "secondPublicKey": "Second signature public key. Hex"
	
.PARAMETER Address
	Address of account.
	
.EXAMPLE
	Get-PsLiskAccount -Address 10829835517993670808L
#>

Function Get-PsLiskAccount
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $Address
        )
	
	$Private:Output = Invoke-PsLiskApiCall -Method Get -URI $( $Script:PsLisk_URI+'accounts?address='+$Address )
	if( $Output.success -eq $True ) { $Output.account }
}

##########################################################################################################################################################################################################

<#
.SYNOPSIS
	API Call: Get the balance of an account.
	
.DESCRIPTION
	Return an object with following properties:
	
	"Balance":     "Balance of account",
	"Balance_U":   "Unconfirmed balance of account"
	"Balance_C":   "Balance of account / 100000000",
	"Balance_UC":  "Unconfirmed balance of account / 100000000"
	
.PARAMETER Address
	Address of account.

.EXAMPLE
	Get-PsLiskAccountBalance -Address 10829835517993670808L
#>

Function Get-PsLiskAccountBalance
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $Address
        )
	
	$Private:Output = Invoke-PsLiskApiCall -Method Get -URI $( $Script:PsLisk_URI+'accounts/getBalance/?address='+$Address )
	if( $Output.success -eq $True )
	{
		New-Object PSObject -Property @{
			'Balance_UC'  = $($Output.UnconfirmedBalance/100000000)
			'Balance_C'   = $($Output.Balance/100000000)
			'Balance_U'   = $Output.UnconfirmedBalance
			'Balance'     = $Output.Balance
			}
	}
}

##########################################################################################################################################################################################################

<#
.SYNOPSIS
	API Call: Get account public key.
	
.DESCRIPTION
	Get the public key of an account.
	
.PARAMETER Address
	Address of account.
	
.EXAMPLE
	Get-PsLiskAccountPublicKey -Address 10829835517993670808L
#>

Function Get-PsLiskAccountPublicKey
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $Address
        )
	
	$Private:Output = Invoke-PsLiskApiCall -Method Get -URI $( $Script:PsLisk_URI+'accounts/getPublicKey?address='+$Address )
	if( $Output.success -eq $True ) { $Output.publicKey }
}

##########################################################################################################################################################################################################

<#
.SYNOPSIS
	API Call: Get votes by account address.
	
.DESCRIPTION
	Get votes statistics from other addresses to the account address.
	
.PARAMETER Address
	Address of account.

.EXAMPLE
	Get-PsLiskAccountVote -Address 10829835517993670808L
#>

Function Get-PsLiskAccountVote
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $Address
        )
	
	$Private:Output = Invoke-PsLiskApiCall -Method Get -URI $( $Script:PsLisk_URI+'accounts/delegates?address='+$Address )
	if( $Output.success -eq $True ) { $Output.delegates }
}

##########################################################################################################################################################################################################

<#
Get second signature of account.

GET /api/signatures/get?id=id

id: Id of signature. (String)

Response
    "signature" : {
        "id" : "Id. String",
        "timestamp" : "TimeStamp. Integer",
        "publicKey" : "Public key of signature. hex",
        "generatorPublicKey" : "Public Key of Generator. hex",
        "signature" : [array],
        "generationSignature" : "Generation Signature"
    }
#>

Function Get-PsLiskAccountSecondSignature
{

}

##########################################################################################################################################################################################################

<#
.SYNOPSIS
	API Call: Create a new account.
	
.DESCRIPTION
	A new account is created.
	Return an object with the following properties:

		"address": "Address of account. String",
		"publicKey": "Public key of account. Hex",
	
.PARAMETER Secret
	Secret key of account.
	
.EXAMPLE
	New-PsLiskAccount -Secret 'soon control wild distance sponsor decrease cheap example avoid route ten pudding'
#>

Function New-PsLiskAccount
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $Secret
        )
	
	$Private:Output = Invoke-PsLiskApiCall -Method Post -URI $( $Script:PsLisk_URI+'accounts/generatePublicKey' ) -Body @{secret=$Secret}
	if( $Output.success -eq $True )
	{
		New-Object PSObject -Property @{
			'PublicKey'  = $Output.publicKey
			'Address'    = 'NOT CODED YET!'
			}
	}
}

##########################################################################################################################################################################################################

<#
.SYNOPSIS
	API Call: Get information about an account.
	
.DESCRIPTION
	Get information about an account.
	Return an object with the following properties:

		"address": "Address of account. String",
		"unconfirmedBalance": "Unconfirmed balance of account. Integer",
		"balance": "Balance of account. Integer",
		"publicKey": "Public key of account. Hex",
		"unconfirmedSignature": "If account enabled second signature, but it's still not confirmed. Boolean: true or false",
		"secondSignature": "If account enabled second signature. Boolean: true or false",
		"secondPublicKey": "Second signature public key. Hex",
		"username": "Username of account."
	
.PARAMETER Secret
	Secret key of account.
	
.EXAMPLE
	Open-PsLiskAccount -Secret 'soon control wild distance sponsor decrease cheap example avoid route ten pudding'
#>

Function Open-PsLiskAccount
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $Secret
        )
	
	$Private:Output = Invoke-PsLiskApiCall -Method Post -URI $( $Script:PsLisk_URI+'accounts/open' ) -Body @{secret=$Secret}
	if( $Output.success -eq $True ) { $Output.account }
}

##########################################################################################################################################################################################################

<#
Vote for the selected delegates. Maximum of 33 delegates at once.
PUT /api/accounts/delegates

Request
    "secret" : "Secret key of account",
    "publicKey" : "Public key of sender account, to verify secret passphrase in wallet. Optional, only for UI",
    "secondSecret" : "Secret key from second transaction, required if user uses second signature",
    "delegates" : "Array of string in the following format: ["+DelegatePublicKey"] OR ["-DelegatePublicKey"]. Use + to UPvote, - to DOWNvote"

Response
    "success": true,
    "transaction": {object}
#>

Function Add-PsLiskAccountVote
{
	# Add support for PublickKey, Address, Delegate Name
	# Validate NbEntry >=1 && <= 33
}

##########################################################################################################################################################################################################

<#
Vote for the selected delegates. Maximum of 33 delegates at once.
PUT /api/accounts/delegates

Request
    "secret" : "Secret key of account",
    "publicKey" : "Public key of sender account, to verify secret passphrase in wallet. Optional, only for UI",
    "secondSecret" : "Secret key from second transaction, required if user uses second signature",
    "delegates" : "Array of string in the following format: ["+DelegatePublicKey"] OR ["-DelegatePublicKey"]. Use + to UPvote, - to DOWNvote"

Response
    "success": true,
    "transaction": {object}
#>

Function Remove-PsLiskAccountVote
{
	# Add support for PublickKey, Address, Delegate Name
}

##########################################################################################################################################################################################################

<#
Add second signature to account.

PUT /api/signatures

Request
  "secret": "secret key of account",
  "secondsecret": "second key of account",
  "publicKey": "optional, to verify valid secret key and account"

Response
  "transactionId": "id of transaction with new signature",
  "publicKey": "Public key of signature. hex"
#>

Function Add-PsLiskSecondSignature
{

}

##########################################################################################################################################################################################################
### API Call: Loader
##########################################################################################################################################################################################################

<#
Returns account's delegates by address.

GET /api/loader/status

   "success": true,
   "loaded": "Is blockchain loaded? Boolean: true or false",
   "now": "Last block loaded during loading time. Integer",
   "blocksCount": "Total blocks count in blockchain at loading time. Integer"
#>

Function Get-PsLiskLoadingStatus
{   

}

##########################################################################################################################################################################################################

<#
Get the synchronisation status of the client.

GET /api/loader/status/sync

Response
   "success": true,
   "sync": "Is wallet is syncing with another peers? Boolean: true or false",
   "blocks": "Number of blocks remaining to sync. Integer",
   "height": "Total blocks in blockchain. Integer"
#>

Function Get-PsLiskSyncStatus
{
	# Proper Conversion ?
	#(Invoke-WebRequest -Uri https://example.com/api/loader/status/sync  | ConvertFrom-Json).height | % {(Invoke-WebRequest -Uri https://example.com/api/blocks?height=$_ | ConvertFrom-Json).blocks.timestamp} | % {[timezone]::CurrentTimeZone.ToLocalTime(([datetime]'4/9/2015').Addseconds($_))}

}

##########################################################################################################################################################################################################
### API Call: Transactions
##########################################################################################################################################################################################################

<#
Get transaction matched by id.

GET /api/transactions/get?id=id

id: String of transaction (String)

Response
	"transaction": {
		"id": "Id of transaction. String",
		"type": "Type of transaction. Integer",
		"subtype": "Subtype of transaction. Integer",
		"timestamp": "Timestamp of transaction. Integer",
		"senderPublicKey": "Sender public key of transaction. Hex",
		"senderId": "Address of transaction sender. String",
		"recipientId": "Recipient id of transaction. String",
		"amount": "Amount. Integer",
		"fee": "Fee. Integer",
		"signature": "Signature. Hex",
		"signSignature": "Second signature. Hex",
		"companyGeneratorPublicKey": "If transaction was sent to merchant, provided comapny generator public key to find company. Hex",
		"confirmations": "Number of confirmations. Integer"
	}
#>

Function Get-PsLiskTransaction
{

}

##########################################################################################################################################################################################################

<#
Get list of transactions

Transactions list matched by provided parameters.

GET /api/transactions?blockId=blockId&senderId=senderId&recipientId=recipientId&limit=limit&offset=offset&orderBy=field

    blockId: Block id of transaction. (String)
    senderId: Sender address of transaction. (String)
    recipientId: Recipient of transaction. (String)
    limit: Limit of transaction to send in response. Default is 20. (Number)
    offset: Offset to load. (Integer number)
    orderBy: Name of column to order. After column name must go "desc" or "acs" to choose order type, prefix for column name is t_. Example: orderBy=t_timestamp:desc (String)

All parameters joins by "OR".

Example:
/api/transactions?blockId=10910396031294105665&senderId=6881298120989278452C&orderBy=timestamp:desc looks like: blockId=10910396031294105665 OR senderId=6881298120989278452C

Response
	"transactions": [
		"list of transactions objects"
#>

Function Get-PsLiskTransactionList
{

}

##########################################################################################################################################################################################################

<#
Get unconfirmed transaction by id.

GET /api/transactions/unconfirmed/get?id=id

id: String of transaction (String)

Response
	"transaction": {
		"id": "Id of transaction. String",
		"type": "Type of transaction. Integer",
		"subtype": "Subtype of transaction. Integer",
		"timestamp": "Timestamp of transaction. Integer",
		"senderPublicKey": "Sender public key of transaction. Hex",
		"senderId": "Address of transaction sender. String",
		"recipientId": "Recipient id of transaction. String",
		"amount": "Amount. Integer",
		"fee": "Fee. Integer",
		"signature": "Signature. Hex",
		"signSignature": "Second signature. Hex",
		"confirmations": "Number of confirmations. Integer"
#>

Function Get-PsLiskTransactionUnconfirmed
{

}

##########################################################################################################################################################################################################

<#
Get list of unconfirmed transactions

GET /api/transactions/unconfirmed

Response
    "transactions" : [list of transaction objects]
#>

Function Get-PsLiskTransactionUnconfirmedList
{

}

##########################################################################################################################################################################################################

<#
Send transaction to broadcast network.

PUT /api/transactions

Request
    "secret" : "Secret key of account",
    "amount" : /* Amount of transaction * 10^8. Example: to send 1.1234 LISK, use 112340000 as amount */,
    "recipientId" : "Recipient of transaction. Address or username.",
    "publicKey" : "Public key of sender account, to verify secret passphrase in wallet. Optional, only for UI",
    "secondSecret" : "Secret key from second transaction, required if user uses second signature"

Response
	"transactionId": "id of added transaction"
#>

Function Send-PsLiskTransaction
{

}

##########################################################################################################################################################################################################
### API Call: Peers
##########################################################################################################################################################################################################

<#
Get peer

Get peer by ip and port

GET /api/peers/get?ip=ip&port=port

    ip: Ip of peer. (String)
    port: Port of peer. (Integer)

Response

{
  "success": true,
  "peer": "peer object"
}
#>

Function Get-PsLiskPeer
{
	$Private:Output = Invoke-PsLiskApiCall -Method Get -URI $( $Script:PsLisk_URI+'peers' )
	if( $Output.success -eq $True ) { $Output.peers }
}

##########################################################################################################################################################################################################

<#
Get peers list

Get peers list by parameters.

GET /api/peers?state=state&os=os&shared=shared&version=version&limit=limit&offset=offset&orderBy=orderBy

    state: State of peer. 1 - disconnected. 2 - connected. 0 - banned. (String)
    os: OS of peer. (String)
    shared: Is peer shared? Boolean: true or false. (String)
    version: Version of peer. (String)
    limit: Limit to show. Max limit is 100. (Integer)
    offset: Offset to load. (Integer)
    orderBy: Name of column to order. After column name must go "desc" or "acs" to choose order type. (String)

All parameters joins by "OR".

Example:
/api/peers?state=1&version=0.1.8 looks like: state=1 OR version=0.1.8

Response
  "peers": ["list of peers"]
#>

Function Get-PsLiskPeerList
{

}

##########################################################################################################################################################################################################

<#
Get peer version and build time

GET /api/peers/version

Response
  "version": "version of Lisk",
  "build": "time of build"
#>

Function Get-PsLiskPeerListVersion
{

}

##########################################################################################################################################################################################################
### API Call: Blocks
##########################################################################################################################################################################################################

<#
Get block by id.

GET /api/blocks/get?id=id

    id: Id of block.

Response
    "block": {
        "id": "Id of block. String",
        "version": "Version of block. Integer",
        "timestamp": "Timestamp of block. Integer",
        "height": "Height of block. Integer",
        "previousBlock": "Previous block id. String",
        "numberOfRequests": "Not using now. Will be removed in 0.2.0",
        "numberOfTransactions": "Number of transactions. Integer",
        "numberOfConfirmations": "Not using now.",
        "totalAmount": "Total amount of block. Integer",
        "totalFee": "Total fee of block. Integer",
        "payloadLength": "Payload length of block. Integer",
        "requestsLength": "Not using now. Will be removed in 0.2.0",
        "confirmationsLength": "Not using now.,
        "payloadHash": "Payload hash. Hex",
        "generatorPublicKey": "Generator public key. Hex",
        "generatorId": "Generator id. String.",
        "generationSignature": "Generation signature. Not using. Will be removed in 0.2.0",
        "blockSignature": "Block signature. Hex"
    }
#>

Function Get-PsLiskBlock
{

}

##########################################################################################################################################################################################################

<#
Get all blocks.

GET /api/blocks?generatorPublicKey=generatorPublicKey&height=height&previousBlock=previousBlock&totalAmount=totalAmount&totalFee=totalFee&limit=limit&offset=offset&orderBy=orderBy

All parameters joins by OR.

Example:
/api/blocks?height=100&totalAmount=10000 looks like: height=100 OR totalAmount=10000

    totalFee: total fee of block. (Integer)
    totalAmount: total amount of block. (Integer)
    previousBlock: previous block of need block. (String)
    height: height of block. (Integer)
    generatorPublicKey: generator id of block in hex. (String)
    limit: limit of blocks to add to response. Default to 20. (Integer)
    offset: offset to load blocks. (Integer)
    orderBy: field name to order by. Format: fieldname:orderType. Example: height:desc, timestamp:asc (String)

Response
  "blocks": [
    "array of blocks"
  ]
#>

Function Get-PsLiskBlockList
{

}

##########################################################################################################################################################################################################

<#
Get blockchain fee percent

GET /api/blocks/getFee

Response
  "fee": "fee percent"
#>

Function Get-PsLiskBlockFee
{

}

##########################################################################################################################################################################################################

<#
Get blockchain height.

GET /api/blocks/getHeight

Response
  "height": "Height of blockchain. Integer"
#>

Function Get-PsLiskBlockHeight
{

}

##########################################################################################################################################################################################################

<#
Get amount forged by account.

GET /api/delegates/forging/getForgedByAccount?generatorPublicKey=generatorPublicKey

generatorPublicKey: generator id of block in hex. (String)

Response
  "sum": "Forged amount. Integer"
#>

Function Get-PsLiskBlockForged
{

}

##########################################################################################################################################################################################################
### API Call: Delegates
##########################################################################################################################################################################################################

<#
Get delegate by transaction id.

GET /api/delegates/get?id=transactionId

transactionId: Id of transaction where delegated was putted. (String)

Response
    "delegate":
        "username": "username of delegate",
        "transactionId": "transaction id",
        "votes": "amount of stake voted for this delegate"
#>

Function Get-PsLiskDelegate
{

}

##########################################################################################################################################################################################################

<#
Get delegates list.

GET /api/delegates?limit=limit&offset=offset&orderBy=orderBy

    limit: Limit to show. Integer. Maximum is 100. (Integer)
    offset: Offset (Integer)
    orderBy: Order by field (String)

Response
  delegates objects array"
	Object includes:
		delegateId,
		address,
		publicKey,
		vote (# of votes),
		producedBlocks,
		missedBlocks,
		rate,
		productivity
#>

Function Get-PsLiskDelegateList
{

}

##########################################################################################################################################################################################################

<#
Get voters of delegate.

GET /api/delegates/voters?publicKey=publicKey

publicKey: Public key of delegate. (String)

Response
  "accounts": [
    "array of accounts who vote for delegate"
  ]
#>

Function Get-PsLiskDelegateVoterList
{

}

##########################################################################################################################################################################################################

<#
Enable delegate on account
Calls for delegates functional.

PUT /api/delegates

Request
  "secret": "Secret key of account",
  "secondSecret": "Second secret of account",
  "username": "Username of delegate. String from 1 to 20 characters."

Response
  "transaction": "transaction object"

Function Enable-PsLiskDelegate
{

}

OR

Function New-PsLiskDelegate
{

}
#>

##########################################################################################################################################################################################################

<#
Enable forging on delegate

POST /api/delegates/forging/enable

Request
  "secret": "secret key of delegate account"

Response
  "address": "address"
#>

Function Enable-PsLiskDelegateForging
{

}

##########################################################################################################################################################################################################

<#
Disable forging on delegate

POST /api/delegates/forging/disable

Request
  "secret": "secret key of delegate account"

Response
  "address": "address"
#>

Function Disable-PsLiskDelegateForging
{

}

##########################################################################################################################################################################################################
### API Call: Multi-Signature
##########################################################################################################################################################################################################

<#
Get pending multi-signature transactions
Return multisig transaction that waiting for your signature.

GET /api/multisignatures/pending?publicKey=publicKey

publicKey: Public key of account (String)

Response
    "transactions": ['array of transactions to sign']
#>

Function Get-PsLiskMultiSigPendingTransactionList
{

}

##########################################################################################################################################################################################################

<#
Get accounts of multisignature.

GET /api/multisignatures/accounts?publicKey=publicKey

publicKey: Public key of multi-signature account (String)

Response
  "accounts": "array of accounts"
#>

Function Get-PsLiskMultiSigAccountList
{

}

##########################################################################################################################################################################################################

<#
Create multi-signature account

PUT /api/multisignatures

Request
    "secret": "your secret. string. required.",
    "lifetime": "request lifetime in hours (1-24). required.",
    "min": "minimum signatures needed to approve a tx or a change (1-15). integer. required",
    "keysgroup": [array of public keys strings]. add '+' before publicKey to add an account or '-' to remove. required. 

Response
  "transactionId": "transaction id"
#>

Function New-PsLiskMultiSigAccount
{

}

##########################################################################################################################################################################################################

<#
Sign transaction that wait for your signature.

POST /api/multisignatures/sign

Request
  "secret": "your secret. string. required.",
  "publicKey": "public key of your account. string. optional.",
  "transactionId": "id of transaction to sign"

Response
  "transactionId": "transaction id"
#>

Function Sign-PsLiskMultiSigTransaction
{

}

##########################################################################################################################################################################################################
### Internal Functions
##########################################################################################################################################################################################################

Function Invoke-PsLiskApiCall
{
    [CmdletBinding()]
    Param(
        [parameter(Mandatory = $True)] [string] $URI,
		
		[parameter(Mandatory = $True)]
		[ValidateSet('Get','Post','Put')]
		[string] $Method,
		
		[parameter(Mandatory = $False)] $Body = @{}
        )
		
	if( ( $Method -eq 'Get' ) -or ( $Method -eq 'Put' ) )
	{
		Write-Verbose "Invoke-PsLiskApiCall [$Method] => $URI"
		$Private:WebRequest = Invoke-WebRequest -Uri $URI -Method $Method
	}
	elseif( $Method -eq 'Post' )
	{
		Write-Verbose "Invoke-PsLiskApiCall [$Method] => $URI"
		$Private:WebRequest = Invoke-WebRequest -Uri $URI -Method $Method -Body $Body
	}
	
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
	Write-Host '    PSLisk | PowerShell Module for Lisk API.     | https://github.com/Gr33nDrag0n69/PsLisk/'
	Write-Host ''
}

##########################################################################################################################################################################################################
