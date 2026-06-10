$location = "canadacentral"
$rgName = "rg-demo-secure"
$vnetName = "vnet-demo"
$nsgName = "nsg-web"

$vnet = Get-AzVirtualNetwork `
  -Name $vnetName `
  -ResourceGroupName $rgName

$nsg = Get-AzNetworkSecurityGroup `
  -Name $nsgName `
  -ResourceGroupName $rgName `

Set-AzVirtualNetworkSubnetConfig `
  -Name "snet-workload" `
  -VirtualNetwork $vnet `
  -AddressPrefix "10.0.1.0/24" `
  -NetworkSecurityGroup $nsg

$vnet | Set-AzVirtualNetwork
