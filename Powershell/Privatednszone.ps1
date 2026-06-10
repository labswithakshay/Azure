$location = "canadacentral"
$rgName = "rg-demo-secure"
$vnetName = "vnet-demo"

$blobZoneName = "privatelink.blob.core.windows.net"
$kvZoneName = "privatelink.vaultcore.azure.net"

$blobZone = New-AzPrivateDnsZone `
  -ResourceGroupName $rgName `
  -Name $blobZoneName

$kvZone = New-AzPrivateDnsZone `
  -ResourceGroupName $rgName `
  -Name $kvZoneName

$vnet = Get-AzVirtualNetwork `
  -Name $vnetName `
  -ResourceGroupName $rgName

New-AzPrivateDnsVirtualNetworkLink `
  -ResourceGroupName $rgName `
  -ZoneName $blobZoneName `
  -Name "link-blob-zone-to-vnet" `
  -VirtualNetworkId $vnet.Id `
  -EnableRegistration $false

New-AzPrivateDnsVirtualNetworkLink `
  -ResourceGroupName $rgName `
  -ZoneName $kvZoneName `
  -Name "link-kv-zone-to-vnet" `
  -VirtualNetworkId $vnet.Id `
  -EnableRegistration $false
