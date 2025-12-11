data "azurerm_client_config" "current" {}

resource "azurerm_bot_service_azure_bot" "merlin-bot" {
  name                    = "merlin-bot"
  resource_group_name     = data.azurerm_resource_group.rg.name
  location                = "global"
  microsoft_app_id        = data.azurerm_client_config.current.client_id
  sku                     = "F0"
  microsoft_app_type      = "SingleTenant"
  microsoft_app_tenant_id = data.azurerm_client_config.current.tenant_id
  endpoint = "https://${azurerm_linux_web_app.wa.default_hostname}/api/messages"
}

