terraform {
  backend "azurerm" {
    resource_group_name  = var.resource_group_name_prefix
    storage_account_name = var.storage_account_name
    container_name       = "tfstate"
    key                  = "dci-central-terraform.tfstate"
  }
}

# Uncomment this to create a storage account name for storing terraform state file.
#module "azure_storage" {
#    source = "../../modules/azure_storage"
#}

module "azure_mysql" {
    source = "../../modules/azure_mysql"
}

module "app_service" {
    source = "../../modules/app_service"
}
