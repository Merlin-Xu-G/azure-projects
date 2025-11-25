data "azurerm_client_config" "current" {}

resource "azurerm_bot_service_azure_bot" "merlin-test-bot" {
  name                = "merlin-test-bot"
  resource_group_name = azurerm_resource_group.merlin-bot-test.name
  location            = "global"
  microsoft_app_id    = data.azurerm_client_config.current.client_id
  sku                 = "F0"
  microsoft_app_type = "SingleTenant"
  microsoft_app_tenant_id = data.azurerm_client_config.current.tenant_id
}