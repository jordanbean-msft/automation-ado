param (
    [Parameter(Mandatory=$true)][String]$ResourceGroupName,
    [Parameter(Mandatory=$true)][String]$SourceControlType = "VsoGit",
    [Parameter(Mandatory=$true)][String]$SourceControlBranch = "main",
    [Parameter(Mandatory=$true)][String]$AdoAccountName,
    [Parameter(Mandatory=$true)][String]$RepositoryName,
    [Parameter(Mandatory=$true)][String]$PathToRunbooks,
    [Parameter(Mandatory=$true)][SecureString]$AdoPat
)

$errorActionPreference = "stop"

Import-Module Az.Resources
Import-Module Az.Automation

$automationAccountName = (Get-AzResource -ResourceGroupName $ResourceGroupName | Where-Object ResourceType -eq "Microsoft.Automation/automationAccounts").name

if(!$automationAccountName) {
  throw 'Unable to find Automation Account in $ResourceGroupName'
}

New-AzAutomationSourceControl -Name SCReposGit `
                              -RepoUrl https://dev.azure.com/$AdoAccountName/_git/$RepositoryName `
                              -SourceType $SourceControlType `
                              -AccessToken $AdoPat `
                              -Branch $SourceControlBranch `
                              -ResourceGroupName $ResourceGroupName `
                              -AutomationAccountName $automationAccountName `
                              -FolderPath "/$PathToRunbooks"