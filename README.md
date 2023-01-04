# API_Net7_POC

This is an example on a .net 7 API with the openAPI specification and basic dependencies for an API application in Azure. It also contains the deployment of the API to API Management. The thought is that the API management is dived in three parts. One for API Management- the service. One for the surrounding resources such as products and user groups etc. This is the third part of the API representation. The API and the API Management gateway representation of that API. 

Requirements
* Azure CLI (az)
* Azure Biceps module
* Azure account
* .Net 7
* VS code or any other text editor and a terminal


## Usage

The project is verry simple and only contain the bicep and configuration that is needed.
The command.sh contain the needed command to crate the “app service plan” and “API App instance” and using bicep and Azure CLI (az commands)

start with loging in to your Azure account

```bash
az login
```

select subscription

```bash
az account set --subscription <subscription id> 
```

Create a resource group (this can of course be done in biceps also)

```bash
az group create -l <locaton> -n <resource group name>
```

## For the App service 
To deploy the app service instance run the AppService.bicep file together with AppService-DEV.parameters.json in the Scaffolding folder. OBS! The *.parameters.json needs to be updated with your details. 

```bash
az deployment group create --resource-group <resource group> --template-file Deployment/Scaffolding/AppService.bicep --parameters Deployment/Scaffolding/AppService-DEV.parameter.json
```
## For API App  
To deploy API App, run APIApp.bicep file together with APIApp-DEV.parameters.json. from the API folder. OBS! *..parameters.json needs to be updated with your details. 

```bash
az deployment group create --resource-group <resource group> --template-file Deployment/API/APIApp.bicep --parameters Deployment/API/APIApp-DEV.parameter.json
```
## Deploy the code  
Deploy the code to the API App. Use VS code, use Az or any other of the ways that are available.

```bash
az webapp deployment list-publishing-credentials --name <API app name> --resource-group <resource-group-name> --subscription <subscription id>
```
## For API Management representation  
To deploy API App, run GameAPIApp.bicep file together with GameAPIApp-DEV.parameters.json. from the APIM folder. OBS! *..parameters.json, GameAPIAppPolicy.xml, GameAPIApp-OpenAPI.json needs to be updated with your details. 
The easiest way of getting the OpenAPI specification is to brows the API url and add /swagger. 

```bash
az deployment group create --resource-group <resource-group-name of API manager> --template-file Deployment/APIM/GameAPIApp.bicep --parameters Deployment/APIM/GameApiApp-dev.parameter.json
```



## Contributing
This is just a repo for my own reference. If it can help anyone else, great. But it is only a POC to investigate API in .net 7 with OpenAPI specification together with APIM and Bicep. It is not designed for production or even test usage but as a get started example. 

## License

[MIT](https://choosealicense.com/licenses/mit/)
