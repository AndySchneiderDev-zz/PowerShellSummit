Function New-ProxyFunction {
param ($command)
$metaData = New-Object System.Management.Automation.CommandMetaData (Get-Command $command) [System.Management.Automation.ProxyCommand]::create($MetaData) }

New-ProxyFunction Get-Process | clip