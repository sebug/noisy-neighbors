// Adapted from https://github.com/Azure/azure-quickstart-templates/blob/master/demos/nested-vms-in-virtual-network/main.bicep
@description('The base URI where artifacts required by this template are located including a trailing \'/\'')
param _artifactsLocation string = 'https://github.com/sebug/noisy-neighbors/raw/main/'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Resource Name for Public IP address attached to Hyper-V Host')
param HostPublicIPAddressName string = 'HVHOSTPIP'

@description('Hyper-V Host and Guest VMs Virtual Network')
param virtualNetworkName string = 'VirtualNetwork'

@description('Virtual Network Address Space')
param virtualNetworkAddressPrefix string = '10.0.0.0/22'

@description('NAT Subnet Name')
param NATSubnetName string = 'NAT'

@description('NAT Subnet Address Space')
param NATSubnetPrefix string = '10.0.0.0/24'

@description('Hyper-V Host Subnet Name')
param hyperVSubnetName string = 'Hyper-V-LAN'


