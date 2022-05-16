# Adding Users to Azure DevTest Lab to Lab User role. 

# USAGE: 
# 1) Using default parameters (see and modify parameters below)
#  ./powershell_add_users_to_Az_devtest.ps1
# 
# 2) Specify CSV file from command line. Other parameters (subscription, resource group and lab name) are as default
# ./powershell_add_users_to_Az_devtest.ps1 -file "users.csv"
# 
# 3) Specify CSV file and lab name. Other parameters (resource group, lab name) as default
# ./powershell_add_users_to_Az_devtest.ps1 -file "myUsers.csv" -lab "myLab"
#
# 4) Specify all parameters from command line. No default parameters will be used. 
# ./powershell_add_users_to_Az_devtest.ps1 -file "myUsers.csv" -sub "my-azure-subscription-id" -rg "myResourceGroup" -lab "myLab"

# Defining default parameter settings. Modify if using all or some of them as default.
param (
	[string]$file = "<default_file>.csv",
	[string]$sub = "<default subscription id>",
	[string]$rg = "<default resource group containing the devtest lab>",
	[string]$lab = "<default devtest lab name>"
)

# Change the following settings according your subscription, resource group and DevTest Lab name
$subscriptionId = $sub
$labResourceGroup = $rg
$labName = $lab

# Log into Azure using lab administrators account (mandatory)
Connect-AzAccount

# Select the Azure subscription that contains the lab. 
Select-AzSubscription -SubscriptionId $subscriptionId

# Read the contents of given CSV file containing users to be added to Lab Users' role
$users = Import-Csv -Path $file -Header "ID"

# Iterate list of users and add them to appropriate role to specified Azure DevTest Lab
Foreach ($userName in $users) {
	# Retrieve user object
	$userName.ID
	$adObject = Get-AzADUser -UserPrincipalName $userName.ID
	$adObject.DisplayName
	$adObject.Mail
	
	# Create the role assignment. 
	$labId = ('/subscriptions/' + $subscriptionId + '/resourceGroups/' + $labResourceGroup + '/providers/Microsoft.DevTestLab/labs/' + $labName)
	
	New-AzRoleAssignment -ObjectId $adObject.Id -RoleDefinitionName 'DevTest Labs User' -Scope $labId
}
