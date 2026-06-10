$tenantId = (Get-AzContext).Tenant.Id

$keyVault = New-AzKeyVault `
  -Name $keyVaultName `
  -ResourceGroupName $rgName `
  -Location $location `
  -TenantId $tenantId `
  -Sku Standard `
  -PublicNetworkAccess Disabled

$kvPeConnection = New-AzPrivateLinkServiceConnection `
  -Name "pls-keyvault" `
  -PrivateLinkServiceId $keyVault.ResourceId `
  -GroupId "vault"

$kvPe = New-AzPrivateEndpoint `
  -Name "pe-keyvault" `
  -ResourceGroupName $rgName `
  -Location $location `
  -Subnet $peSubnet `
  -PrivateLinkServiceConnection $kvPeConnection

$kvDnsConfig = New-AzPrivateDnsZoneConfig `
  -Name $kvZoneName `
  -PrivateDnsZoneId $kvZone.ResourceId

New-AzPrivateDnsZoneGroup `
  -ResourceGroupName $rgName `
  -PrivateEndpointName "pe-keyvault" `
  -Name "default" `
  -PrivateDnsZoneConfig $kvDnsConfig
