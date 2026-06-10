$location = "canadacentral"
$rgName = "rg-demo-secure"
$vnetName = "vnet-demo"
# Must be globally unique, lowercase, 3-24 chars
$storageName = "stdemo$(Get-Random -Minimum 10000 -Maximum 99999)"


$storage = New-AzStorageAccount `
  -ResourceGroupName $rgName `
  -Name $storageName `
  -Location $location `
  -SkuName Standard_LRS `
  -Kind StorageV2 `
  -AccessTier Hot `
  -PublicNetworkAccess Disabled

$vnet = Get-AzVirtualNetwork `
  -Name $vnetName `
  -ResourceGroupName $rgName

$peSubnet = Get-AzVirtualNetworkSubnetConfig `
  -Name "snet-private-endpoint" `
  -VirtualNetwork $vnet

$storagePeConnection = New-AzPrivateLinkServiceConnection `
  -Name "pls-storage-blob" `
  -PrivateLinkServiceId $storage.Id `
  -GroupId "blob"

$storagePe = New-AzPrivateEndpoint `
  -Name "pe-storage-blob" `
  -ResourceGroupName $rgName `
  -Location $location `
  -Subnet $peSubnet `
  -PrivateLinkServiceConnection $storagePeConnection

$blobDnsConfig = New-AzPrivateDnsZoneConfig `
  -Name $blobZoneName `
  -PrivateDnsZoneId $blobZone.ResourceId

New-AzPrivateDnsZoneGroup `
  -ResourceGroupName $rgName `
  -PrivateEndpointName "pe-storage-blob" `
  -Name "default" `
  -PrivateDnsZoneConfig $blobDnsConfig
