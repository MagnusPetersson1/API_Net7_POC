
# ========================= some to have az commands to have at hand ======================

# ============= Log in to Azure =============
az login

# ============= list tenants on account =============
az account tenant list

# ============= set subscription context =============
az account set --subscription <subscriptionId>

# ============= Create resource group =============
az group create -l WestEurope -n <resource group name>


# ============= Deploy the app sevice plan =============

az deployment group create --resource-group <resource group> --template-file Deployment/Scaffolding/AppService.bicep --parameters Deployment/Scaffolding/AppService-DEV.parameter.json

# ============ Deploy the API App ================
az deployment group create --resource-group <resource group> --template-file Deployment/API/APIApp.bicep --parameters Deployment/API/APIApp-DEV.parameter.json


#  ============= Deploy the code =============
az webapp deployment list-publishing-credentials --name <API app name> --resource-group <resource-group-name> --subscription <subscription id>

# ============= deploy/add/expose API in api manager  =============

az deployment group create --resource-group <resource-group-name of API manager> --template-file Deployment/APIM/GameAPIApp.bicep --parameters Deployment/APIM/GameApiApp-dev.parameter.json
 



