
Function Get-AdUser {

[CmdletBinding(DefaultParameterSetName='Filter')]
param(
    [Parameter(ParameterSetName='Filter', Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [System.String]
    ${Filter},
    
    [Parameter(ParameterSetName='Filter', Mandatory=$false, ValueFromPipeline=$true, Position=0)]
    [ValidateNotNullOrEmpty()]
    [System.String]
    ${Name},

    [Parameter(ParameterSetName='LdapFilter', Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [System.String]
    ${LDAPFilter},

    [Alias('Property')]
    [ValidateNotNullOrEmpty()]
    [System.String[]]
    ${Properties},

    [Parameter(ParameterSetName='Filter')]
    [Parameter(ParameterSetName='LdapFilter')]
    [ValidateRange(0, 2147483647)]
    [ValidateNotNullOrEmpty()]
    [System.Int32]
    ${ResultPageSize},

    [Parameter(ParameterSetName='LdapFilter')]
    [Parameter(ParameterSetName='Filter')]
    [System.Nullable``1[[System.Int32, mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]
    ${ResultSetSize},

    [Parameter(ParameterSetName='LdapFilter')]
    [Parameter(ParameterSetName='Filter')]
    [ValidateNotNull()]
    [System.String]
    ${SearchBase},

    [Parameter(ParameterSetName='Filter')]
    [Parameter(ParameterSetName='LdapFilter')]
    [ValidateNotNullOrEmpty()]
    [Microsoft.ActiveDirectory.Management.ADSearchScope]
    ${SearchScope},

    [Parameter(ParameterSetName='Identity', Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNull()]
    [Microsoft.ActiveDirectory.Management.ADUser]
    ${Identity},

    [Parameter(ParameterSetName='Identity')]
    [ValidateNotNullOrEmpty()]
    [System.String]
    ${Partition},

    [ValidateNotNullOrEmpty()]
    [System.String]
    ${Server},

    [ValidateNotNullOrEmpty()]
    [System.Management.Automation.PSCredential]
    ${Credential},

    [Microsoft.ActiveDirectory.Management.ADAuthType]
    ${AuthType})

begin
{
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
        {
            $PSBoundParameters['OutBuffer'] = 1
        }
        
        if($PSBoundParameters['Name']) 
        { 
        # Whack the custom parameter
        $null = $PSBoundParameters.Remove('Name')
        $filter = "Name -like `"$Name`""
        # Add in the filter parameter that will get passed to native command 
        $null = $PSBoundParameters.Add("Filter",$filter) 
       
        }
        
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('Get-ADUser', [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters }
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process
{
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end
{
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
<#

.ForwardHelpTargetName Get-ADUser
.ForwardHelpCategory Cmdlet

#>
}
