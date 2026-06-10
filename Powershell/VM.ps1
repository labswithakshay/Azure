# Login
Connect-AzAccount

# Optional: select subscription
# Set-AzContext -SubscriptionId "<your-subscription-id>"

# Common variables
$location = "canadacentral"
$rgName = "rg-demo-secure"
$vnetName = "vnet-demo"

$vmName = "vm-win-demo"
$nicName = "nic-vm-win-demo"


$cred = Get-Credential

$vnet = Get-AzVirtualNetwork `
  -Name $vnetName `
  -ResourceGroupName $rgName

$workloadSubnet = Get-AzVirtualNetworkSubnetConfig `
  -Name "snet-workload" `
  -VirtualNetwork $vnet

$nic = New-AzNetworkInterface `
  -Name $nicName `
  -ResourceGroupName $rgName `
  -Location $location `
  -SubnetId $workloadSubnet.Id


$vmConfig = New-AzVMConfig `
  -VMName $vmName `
  -VMSize "Standard_B2s"

$vmConfig = Set-AzVMOperatingSystem `
  -VM $vmConfig `
  -Windows `
  -ComputerName $vmName `
  -Credential $cred `
  -ProvisionVMAgent `
  -EnableAutoUpdate

$vmConfig = Set-AzVMSourceImage `
  -VM $vmConfig `
  -PublisherName "MicrosoftWindowsServer" `
  -Offer "WindowsServer" `
  -Skus "2022-datacenter-azure-edition" `
  -Version "latest"

$vmConfig = Add-AzVMNetworkInterface `
  -VM $vmConfig `
  -Id $nic.Id

$vmConfig = Set-AzVMOSDisk `
  -VM $vmConfig `
  -Name "$vmName-osdisk" `
  -CreateOption FromImage `
  -Caching ReadWrite `
  -StorageAccountType "Standard_LRS"

New-AzVM `
  -ResourceGroupName $rgName `
  -Location $location `
  -VM $vmConfig
