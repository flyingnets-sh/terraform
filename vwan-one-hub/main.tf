terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
 
    }
}
cloud {
    hostname     = "app.terraform.io"
    organization = "flyingnets-greg"
    workspaces = {
      name = "terraform"
    }
  }

}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

