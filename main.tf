terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
 
    }
}
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
      #subscription_id = var.ARM_SUBSCRIPTION_ID
      #client_id       = var.ARM_CLIENT_ID
      #client_secret   = var.ARM_CLIENT_SECRET
      #tenant_id       = var.ARM_TENANT_ID
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
