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

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create the Linux App Service Plan
resource "azurerm_service_plan" "appserviceplan" {
  name                = "webapp-asp-${random_integer.ri.result}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name_prefix
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "webapp" {
    client_affinity_enabled           = false
    client_certificate_enabled        = false
    client_certificate_mode           = "Required"
    enabled                           = true
    https_only                        = true
    location                          = var.resource_group_location
    name                              = "webapp-${random_integer.ri.result}" 
    resource_group_name               = var.resource_group_name_prefix
    service_plan_id                   = azurerm_service_plan.appserviceplan.id
    app_settings                      = {
        "MYSQL_HOST"     = azure_mysql.azurerm_private_dns_zone_virtual_network_link.default.private_dns_zone_name
        "MYSQL_DB"       = azure_mysql.azurerm_mysql_flexible_database.main.name
        "MYSQL_USER"     = azure_mysql.azurerm_mysql_flexible_server.default.administrator_login
        "MYSQL_PASSWORD" = azure_mysql.azurerm_mysql_flexible_server.default.administrator_password
    }

    site_config {
        always_on                               = false
        container_registry_use_managed_identity = false
        ftps_state                              = "FtpsOnly"
        http2_enabled                           = false
        load_balancing_mode                     = "LeastRequests"
        local_mysql_enabled                     = false
        managed_pipeline_mode                   = "Integrated"
        minimum_tls_version                     = "1.2"
        use_32_bit_worker                       = true
        vnet_route_all_enabled                  = false
        worker_count                            = 1

        application_stack {
            docker_image     = "index.docker.io/ewoh7nix/getting-started"
            docker_image_tag = "latest"
        }
    }

    timeouts {}
}

