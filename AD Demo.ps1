$env:adps_loaddefaultdrive = 0
#get rid of existing default drive
Remove-PSDrive AD

New-PSDrive -Name AD -Root "" -PSProvider ActiveDirectory -FormatType Canonical
# Mess around with ls and dir using wildcards the nicer way

# Demo Get-Process vs Get-ADUser
get-process 
get-process win*
get-process svc*

# Demo Get-Aduser
Get-Aduser Administrator # So far so good
#prompts for filter param - can take * 
Get-Aduser 
# what about finer filter
get-aduser -filter admin*
get-aduser -filter 'name -like "Admin*"' 

# So the out of the box Cmdlet is broken - whats a PS guy to do
# we fix it using Proxy Functions

Walk through New-ProxyFunction and show new "Get-AdUser"
Use Search-ADAccount for accountDisabled, inactive, expiring, lockedout, passwd expired
