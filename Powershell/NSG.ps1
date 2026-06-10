$location = "canadacentral"
$rgName = "rg-demo-secure"
$nsgName = "nsg-web"

$httpRule = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-HTTP" `
  -Description "Allow HTTP inbound" `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 100 `
  -SourceAddressPrefix Internet `
  -SourcePortRange "*" `
  -DestinationAddressPrefix "*" `
  -DestinationPortRange 80

$httpsRule = New-AzNetworkSecurityRuleConfig `
  -Name "Allow-HTTPS" `
  -Description "Allow HTTPS inbound" `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 110 `
  -SourceAddressPrefix Internet `
  -SourcePortRange "*" `
  -DestinationAddressPrefix "*" `
  -DestinationPortRange 443

$nsg = New-AzNetworkSecurityGroup `
  -Name $nsgName `
  -ResourceGroupName $rgName `
  -Location $location `
  -SecurityRules $httpRule, $httpsRule
