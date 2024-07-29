# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}
provider "azurerm" {
  features {}
}

resource "azurerm_storage_account" "dcicentral" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name_prefix
  location                 = var.resource_group_location 
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
