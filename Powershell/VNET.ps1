$vnetName = "vnet-demo"

$workloadSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name "snet-workload" `
  -AddressPrefix "10.0.1.0/24"

$privateEndpointSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name "snet-private-endpoint" `
  -AddressPrefix "10.0.2.0/24" `
  -PrivateEndpointNetworkPoliciesFlag "Disabled"

$bastionSubnet = New-AzVirtualNetworkSubnetConfig `
  -Name "AzureBastionSubnet" `
  -AddressPrefix "10.0.3.0/26"

$vnet = New-AzVirtualNetwork `
  -Name $vnetName `
  -ResourceGroupName $rgName `
  -Location $location `
  -AddressPrefix "10.0.0.0/16" `
  -Subnet $workloadSubnet, $privateEndpointSubnet, $bastionSubnet
