resource "azurerm_resource_group" "test" {
  name     = "${local.subscription_name}-Test-${local.location}"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "test2" {
  name     = "${local.subscription_name}-Test2-${local.location}"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "paul" {
  name     = "${local.subscription_name}-Paul-${local.location}"
  location = local.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "paul2" {
  name     = "${local.subscription_name}-Paul2-${local.location}"
  location = local.location
  tags     = local.common_tags
}
