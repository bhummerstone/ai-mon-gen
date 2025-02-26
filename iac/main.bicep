targetScope = 'subscription'

param location string ='eastus2'

@description('Create a resource group')
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'rg-swa-ai-mon-gen'
  location: location
}

@description('Create a static web app')
module swa 'br/public:avm/res/web/static-site:0.8.0' = {
  name: 'client'
  scope: rg
  params: {
    name: 'swa-ai-mon-gen'
    location: location
    sku: 'Free'
  }
}

@description('Output the default hostname')
output endpoint string = swa.outputs.defaultHostname

@description('Output the static web app name')
output staticWebAppName string = swa.outputs.name
