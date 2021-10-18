param(
    [Parameter(Mandatory=$true)]$SubscriptionId, 
    [Parameter(Mandatory=$true)]$ResourceGroup,
    [Parameter(Mandatory=$true)]$WorkbooksFolder,
    [Parameter(Mandatory=$true)]$Workspace
)

Write-Host "Folder is: $($AutomationRulesFolder)"

$armTemplateFiles = Get-ChildItem -Path $WorkbooksFolder -Filter *.json

Write-Host "Files are: " $armTemplateFiles

$workbookSourceId = "/subscriptions/$SubscriptionId/resourcegroups/$ResourceGroup/providers/microsoft.operationalinsights/workspaces/$Workspace"

foreach ($armTemplate in $armTemplateFiles) {
    try {
        New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateFile $armTemplate
    }
    catch {
        $ErrorMessage = $_.Exception.Message
        Write-Error "Workbook deployment failed with message: $ErrorMessage" 
    }
}