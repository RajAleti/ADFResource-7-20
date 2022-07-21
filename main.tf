resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_data_factory" "rg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
}