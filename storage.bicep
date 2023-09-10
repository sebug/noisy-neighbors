param location string = resourceGroup().location

@description('Name for the storage account.')
param storageAccountName string

@description('Name of the storage account we store the app in')
param appStorageAccountName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

resource appStorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: appStorageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

output storageURI string = storageAccount.properties.primaryEndpoints.blob
