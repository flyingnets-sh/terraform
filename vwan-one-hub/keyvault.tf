# Create KeyVault ID
resource "random_id" "kvname" {
  byte_length = 5
  prefix      = "keyvault"
}
# Keyvault Creation
data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "kv1" {
  depends_on                  = [azurerm_resource_group.region1-rg1]
  name                        = random_id.kvname.hex
  location                    = var.region1
  resource_group_name         = azurerm_resource_group.region1-rg1.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set",
    ]

    storage_permissions = [
      "Get",
    ]
  }
  tags = {
    Environment = var.environment_tag
  }
}
# Create KeyVault VM password
resource "random_password" "vmpassword" {
  length  = 20
  special = true
}
# Also create an SSH key
resource "tls_private_key" "linux_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Create Key Vault Secret
# resource "azurerm_key_vault_secret" "vmpassword" {
#   name         = "vmpassword"
#   value        = random_password.vmpassword.result
#   key_vault_id = azurerm_key_vault.kv1.id
#   depends_on   = [azurerm_key_vault.kv1]
# }

# Creating the Key by importing the SSH private key 
resource "azurerm_key_vault_secret" "linux-ssh-key" {
  name         = "linux-ssh-key"
  value        = tls_private_key.linux_ssh.private_key_pem
  key_vault_id = azurerm_key_vault.poctestkv.id
  depends_on   = [azurerm_key_vault.kv1]
}
