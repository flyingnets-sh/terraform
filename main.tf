terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
/*
tls = {
      source = "hashicorp/tls"
      version = "~>4.0"
    }
*/
  }
backend "azurerm" {
        resource_group_name  = "greg-rg"
        storage_account_name = "tfstate28292"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
