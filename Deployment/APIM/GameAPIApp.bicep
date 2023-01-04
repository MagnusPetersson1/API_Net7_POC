
param apiManagementServiceName string

// Reference to the API Management product so the API can be linked to it
resource GameAPIProduct 'Microsoft.ApiManagement/service/products@2020-12-01' existing ={
  name:'${apiManagementServiceName}/GameAPI-Product'
}
// Parameter of the policy file for APIM
param apimXmlPolicyFile string = loadTextContent('../APIM/GameAPIAppPolicy.xml')

// ================== the API in APIM ==================
resource GameAPIApp 'Microsoft.ApiManagement/service/apis@2020-12-01'= {
name: '${apiManagementServiceName}/GameAPIApp'
properties:{
  displayName:'GameAPIApp'
  format:'openapi'
  value: loadTextContent('../APIM/GameAPIApp-OpenAPI.json')
  path:'GameAPIApp'
  protocols:['https']
  authenticationSettings:{
    oAuth2AuthenticationSettings: [] 
    openidAuthenticationSettings: []
  }
  subscriptionKeyParameterNames:{
    header: 'Ocp-Apim-Subscription-Key'
    query: 'subscription-key'
  }
  isCurrent: true
  }
}

// ================== Link API to Product ==================
resource GameAPIProductLink 'Microsoft.ApiManagement/service/products/apis@2020-12-01' = {
  name:'GameAPIApp'
  parent:GameAPIProduct
  dependsOn:[GameAPIApp]
}

// ================== policy on API ==================
// Create policy with inline string in the bicep
/*
resource LaGameAPIPolicy 'Microsoft.ApiManagement/service/apis/policies@2020-12-01' = {
name:'policy'
parent:LAGameAPI
properties:{
  value:'<policies>\r\n<inbound>\r\n<base />\r\n<rate-limit calls="20" renewal-period="90" remaining-calls-variable-name="remainingCallsPerSubscription"/>\r\n</inbound>\r\n<outbound>\r\n<base />\r\n</outbound>\r\n</policies>'
  format:'xml'
}
}
*/


// ================== policy on API from file ==================
resource GameAPIAppPolicy 'Microsoft.ApiManagement/service/apis/policies@2020-12-01' = {
  name:'policy'
  parent:GameAPIApp
  properties:{
    value:apimXmlPolicyFile
    format:'rawxml'
  }
  }
  
// ================== Policy that will act on Product level ==================
/* 
resource LAGameAPIGroupPolicy 'Microsoft.ApiManagement/service/products/policies@2020-12-01' = {
  name: 'policy'
  parent: GameAPIProduct
  properties: {
    value:'<policies>\r\n<inbound>\r\n<base />\r\n<rate-limit calls="20" renewal-period="90" remaining-calls-variable-name="remainingCallsPerSubscription"/>\r\n</inbound>\r\n<outbound>\r\n<base />\r\n</outbound>\r\n</policies>'
    format:'xml'
  }
}
*/


  
