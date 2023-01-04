

param appServicePlanName string
param webSiteName string
param location string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' existing= {
  name: appServicePlanName
}


resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  kind:'api' 
  properties: {
       serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|7.0'
    }
  }
}
