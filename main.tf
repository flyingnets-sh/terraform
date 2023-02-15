terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.12.0"
    }
  }
}

provider "azurerm" {
    features {} #This is required for v2+ of the provider even if empty or plan will fail
  # Configuration options
}

resource "azurerm_resource_group" "example" {
  name     = "ExampleRG"
  location = "West Europe"
}
