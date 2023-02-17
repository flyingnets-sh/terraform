locals {
  subscription_name  = data.azurerm_subscription.current.display_name
  location           = "ChinaNorth3"
  region_vmname_code = "cn3"
  common_tags = {
    Application = "FlyingNetsPOC"
    CaseCode    = "f4eh"
    Department  = "TSG"
    Owner       = "TSGPlatformInfra"
    Tier        = "Test"
  }
}

locals {
  region_details      = lookup(data.terraform_remote_state.bain-central-virtualwan.outputs.vwan_details, lower(local.location), null)
  region_hub          = lookup(data.terraform_remote_state.bain-central-virtualwan.outputs.hub_details, lower(local.location), null)
  hub_cidr            = local.region_details.hub_cidr
  region_cidrs        = local.region_details.region_cidrs
  sharedservices_cidr = local.region_details.sharedservices_cidr
  vnet_dns_servers    = [local.region_hub.fw_addresses[0].private_ip_address] # Use this for the VNET DNS (Azure Firewall with DNS Proxy enabled)
  region_fw           = local.region_hub.fw_addresses[0].private_ip_address   # Use this for Default Route to Internet via the Firewall
}
