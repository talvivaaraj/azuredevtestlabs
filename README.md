## Azure PowerShell script for automating adding users into Lab User Role to Azure DevTest Lab. :wrench:

### Summary  
Script will read a CSV file containing domain users and automate adding them into a Lab User Role to a specified Azure DevTest Lab. 
Useful when adding several accounts at once, which can turn out to be both monotonous and time-consuming task using web interface, especially the more the number of accounts increase and when working with several lab environments. 

### Prerequisites

* Latest version of Windows PowerShell installed. See detailed [instructions](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell)  
* Azure PowerShell module installed and activated. See detailed [instructions](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps).  
* Access to an Azure Subscription.  
* DevTest Lab created beforehand. See detailed [instructions](https://docs.microsoft.com/en-us/azure/devtest-labs/tutorial-create-custom-lab)  
* Appropriate privileges (Owner or  User Access Administrator) needed for running the script succesfully.  
* Will ask for login to Azure when running the script.  

### The script file

[add_csv_users_to_Az_devtestlab.ps1](https://github.com/talvivaaraj/azuredevtestlabs/blob/8e05c765ac331217205ecc0460b9670b1b8448d5/add_csv_users_to_Az_devtestlab.ps1)  
Save to a local folder with permissions to run PowerShell Script. 


### Use cases
1) Using default parameters (see and modify parameters in the script, parameter section)

```
./powershell_add_users_to_Az_devtest.ps1
```

2) Specify CSV file from command line. Other parameters (subscription id, resource group and lab name) are as default

```
 ./powershell_add_users_to_Az_devtest.ps1 -file "users.csv"
```

3) Specify CSV file and lab name. Other parameters (resource group, subscription id) as default

```
./powershell_add_users_to_Az_devtest.ps1 -file "myUsers.csv" -lab "myLab"
```

4) Specify all parameters from command line. No default parameters will be used. 

```
./powershell_add_users_to_Az_devtest.ps1 -file "myUsers.csv" -sub "my-az-subscription-id" -rg "myResourceGroup" -lab "myLab"
```

### Supported CSV file format

One user per row. Each user account must be eligible Azure Domain Account for your organization (e.g. user@domain.com)

```
HEADER
user1@domain.com 
user2@domain.com
user3@domain.com
...
userN@domain.com
```

Header is not mandatory. When used, header can be named whatever needed and won't affect the script. 
