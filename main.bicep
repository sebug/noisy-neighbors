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

@description('Hyper-V Host Subnet Address Space')
param hyperVSubnetPrefix string = '10.0.1.0/24'

@description('Ghosted Subnet Name')
param ghostedSubnetName string = 'Ghosted'

@description('Ghosted Subnet Address Space')
param ghostedSubnetPrefix string = '10.0.2.0/24'

@description('Azure VMs Subnet Name')
param azureVMsSubnetName string = 'Azure-VMs'

@description('Azure VMs Address Space')
param azureVMsSubnetPrefix string = '10.0.3.0/24'

@description('Hyper-V Host Network Interface 1 Name, attached to NAT Subnet')
param HostNetworkInterface1Name string = 'HVHOSTNIC1'

@description('Hyper-V Host Network Interface 2 Name, attached to Hyper-V LAN Subnet')
param HostNetworkInterface2Name string = 'HVHOSTNIC2'

@description('Name of Hyper-V Host Virtual Machine, Maximum of 15 characters, use letters and numbers only.')
@maxLength(15)
param HostVirtualMachineName string = 'HVHOST'

@description('Size of the Host Virtual Machine')
@allowed([
  'Standard_D2_v3'
  'Standard_D4_v3'
  'Standard_D8_v3'
  'Standard_D16_v3'
  'Standard_D32_v3'
  'Standard_D2s_v3'
  'Standard_D4s_v3'
  'Standard_D8s_v3'
  'Standard_D16s_v3'
  'Standard_D32s_v3'
  'Standard_D64_v3'
  'Standard_E2_v3'
  'Standard_E4_v3'
  'Standard_E8_v3'
  'Standard_E16_v3'
  'Standard_E32_v3'
  'Standard_E64_v3'
  'Standard_D64s_v3'
  'Standard_E2s_v3'
  'Standard_E4s_v3'
  'Standard_E8s_v3'
  'Standard_E16s_v3'
  'Standard_E32s_v3'
  'Standard_E64s_v3'
  'Standard_E4bs_v5'
])
param HostVirtualMachineSize string = 'Standard_E4bs_v5'

@description('Admin Username for the Host Virtual Machine')
param HostAdminUsername string

@description('Admin User Password for the Host Virtual Machine')
@secure()
param HostAdminPassword string

var NATSubnetNSGName = '${NATSubnetName}NSG'
var hyperVSubnetNSGName = '${hyperVSubnetName}NSG'
var ghostedSubnetNSGName = '${ghostedSubnetName}NSG'
var azureVMsSubnetNSGName = '${azureVMsSubnetName}NSG'
var azureVMsSubnetUDRName = '${azureVMsSubnetName}UDR'
var DSCInstallWindowsFeaturesUri = uri(_artifactsLocation, 'dsc/dscinstallwindowsfeatures.zip')
var HVHostSetupScriptUri = uri(_artifactsLocation, 'hvhostsetup.ps1')

