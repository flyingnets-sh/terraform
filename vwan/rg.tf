resource "azurerm_resource_group" "example01" {
  name     = "example01-resources"
  location = "West Europe"
}

resource "azurerm_resource_group" "example02" {
  name     = "example02-resources"
  location = "East Europe"
}