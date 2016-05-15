# PSLisk

PowerShell Module for Lisk API.

Lisk is a Decentralized Application Platform. See https://lisk.io/ for more infos.

I'm using the following documentation for development.

https://github.com/LiskHQ/lisk-docs/blob/master/APIReference.md

and

https://lisk.io/documentation?i=lisk-docs/APIReference

# Install PSLisk in PSModulePath directory. (Recommended)

Download and Extract zip file to 

C:\Program Files\WindowsPowerShell\Modules\

You should have:

C:\Program Files\WindowsPowerShell\Modules\PsLisk\

# Use PSLisk PowerShell Module.

Open PowerShell and run:

Import-Module PsLisk

# Check Available Cmdlets

Get-Command *-PsLisk*

# Check Help on a given cmdlet.

Note: Help might not be written for all cmdlets.

Get-Help CommandName -Full

Example:

Get-Help Set-PsLiskConfiguration -Full
