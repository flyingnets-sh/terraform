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
  features {}
      #subscription_id = var.ARM_SUBSCRIPTION_ID
      #client_id       = var.ARM_CLIENT_ID
      #client_secret   = var.ARM_CLIENT_SECRET
      #tenant_id       = var.ARM_TENANT_ID
}

# Variables
variable "ARM_CLIENT_ID" {
  type        = string
  description = "Name to be used for resources in this lab"
}

variable "ARM_CLIENT_SECRET" {
  type        = string
  description = "Name to be used for resources in this lab"
}
variable "ARM_TENANT_ID" {
  type        = string
  description = "Name to be used for resources in this lab"
}
variable "ARM_SUBSCRIPTION_ID" {
  type        = string
  description = "Name to be used for resources in this lab"
}


resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
