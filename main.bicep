@description('Username for the virtual machines')
param adminUsername string

@description('Password for the virtual machines')
@minLength(12)
@secure()
param adminPassword string

@description('The Windows version for the UDP noisy VMs. This will pick a fully patched image of this given Windows version.')
@allowed([
  '2016-datacenter-gensecond'
  '2016-datacenter-server-core-g2'
  '2016-datacenter-server-core-smalldisk-g2'
  '2016-datacenter-smalldisk-g2'
  '2016-datacenter-with-containers-g2'
  '2016-datacenter-zhcn-g2'
  '2019-datacenter-core-g2'
  '2019-datacenter-core-smalldisk-g2'
  '2019-datacenter-core-with-containers-g2'
  '2019-datacenter-core-with-containers-smalldisk-g2'
  '2019-datacenter-gensecond'
  '2019-datacenter-smalldisk-g2'
  '2019-datacenter-with-containers-g2'
  '2019-datacenter-with-containers-smalldisk-g2'
  '2019-datacenter-zhcn-g2'
  '2022-datacenter-azure-edition'
  '2022-datacenter-azure-edition-core'
  '2022-datacenter-azure-edition-core-smalldisk'
  '2022-datacenter-azure-edition-smalldisk'
  '2022-datacenter-core-g2'
  '2022-datacenter-core-smalldisk-g2'
  '2022-datacenter-g2'
  '2022-datacenter-smalldisk-g2'
])
param OSVersion string = '2022-datacenter-azure-edition'

@description('Size of the virtual machine.')
param vmSize string = 'Standard_D2s_v5'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of the first virtual machine.')
param firstVmName string = 'first-vm'

@description('Name of the second virtual machine')
param secondVmName string = 'second-vm'

@description('Name of the third vm')
param thirdVmName string = 'third-vm'

@description('Security Type of the Virtual Machines.')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'TrustedLaunch'

var storageAccountName = 'bootdiags${uniqueString(resourceGroup().id)}'
var firstNicName = 'firstVMNic'
var secondNicName = 'secondVMNic'
var thirdNicName = 'thirdVmNic'

// we don't really need a frontend, we can connect over Bastion. But nevermind, keeping the same naming standard
// so that we can properly formalize a frontend access if we need to
var backEndSubnetName = 'NNBackEnd'
var backEndSubnetPrefix = '22.22.2.0/24'

var virtualNetworkName = 'MyVNET'
var backendNetworkSecurityGroupName = 'backend-NSG'

var securityProfileJson = {
  uefiSettings: {
    secureBootEnabled: true
    vTpmEnabled: true
  }
  securityType: securityType
}

var extensionName = 'GuestAttestation'
var extensionPublisher = 'Microsoft.Azure.Security.WindowsAttestation'
var extensionVersion = '1.0'
var maaTenantName = 'GuestAttestation'
var maaEndpoint = substring('emptyString', 0, 0)

module storageModule 'storage.bicep' = {
  name: 'storageTemplate'
  params: {
    location: location
    storageAccountName: storageAccountName
  }
}

resource backendNetworkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: backendNetworkSecurityGroupName
  location: location
  properties: {
    securityRules: [
    ]
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    subnets: [
      {
        name: backEndSubnetName
        properties: {
          addressPrefix: backEndSubnetPrefix
          networkSecurityGroup: {
            id: backendNetworkSecurityGroup.id
          }
        }
      }
    ]
  }
}


