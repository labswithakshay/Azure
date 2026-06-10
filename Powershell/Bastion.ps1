$location = "canadacentral"
$rgName = "rg-demo-secure"
$bastionName = "bas-demo"
$bastionPipName = "pip-bastion-demo"
$vnetName = "vnet-demo"

$bastionPip = New-AzPublicIpAddress `
  -Name $bastionPipName `
  -ResourceGroupName $rgName `
  -Location $location `
  -AllocationMethod Static `
  -Sku Standard

New-AzBastion `
  -Name $bastionName `
  -ResourceGroupName $rgName `
  -PublicIpAddressRgName $rgName `
  -PublicIpAddressName $bastionPipName `
  -VirtualNetworkRgName $rgName `
  -VirtualNetworkName $vnetName `
  -Sku Basic
