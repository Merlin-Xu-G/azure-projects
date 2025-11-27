resource "azurerm_container_registry" "acr" {
  name                = "merlintestregistry"
  resource_group_name = azurerm_resource_group.merlin-bot-test.name
  location            = azurerm_resource_group.merlin-bot-test.location
  sku                 = "Basic"
  admin_enabled       = true

}