resource "azurerm_service_plan" "wa-sp" {
  name                = "bot-wa-sp"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.wa_location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "wa" {
  name                = "bot-wa"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.wa_location
  service_plan_id     = azurerm_service_plan.wa-sp.id

  site_config {
    always_on = false
    
    application_stack {
      docker_image_name        = "coe-devops-bot:latest"
      docker_registry_url      = "https://${var.acr_server_url}"
      docker_registry_username = var.acr_admin_username
      docker_registry_password = var.acr_admin_password
    }
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb = 35
      }
    }
  }
}