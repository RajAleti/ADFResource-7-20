resource "azurerm_resource_group" "rg" {
  name     = "rg-test-adf-resources"
  location = "West Europe"
}

resource "azurerm_data_factory" "rg" {
  name                = "Datafactory-128-raja"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}