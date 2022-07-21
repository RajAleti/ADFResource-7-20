resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_data_factory" "rg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault" "rg" {
  name                = var.keyvault_name 
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

resource "azurerm_data_factory_linked_service_key_vault" "rg" {
  name            = var.lkv_name 
  data_factory_id = azurerm_data_factory.rg.id
  key_vault_id    = azurerm_key_vault.rg.id
}

# resource "azurerm_data_factory_linked_service_azure_blob_storage" "rg" {
#   name            = "linkedblob"
#   data_factory_id = azurerm_data_factory.rg.id

#   sas_uri = "https://example.blob.core.windows.net"
#   key_vault_sas_token {
#     linked_service_name = azurerm_data_factory_linked_service_key_vault.rg.name
#     secret_name         = "Hakunamatata"
#   }
# }

resource "azurerm_data_factory_linked_service_azure_blob_storage" "rg" {
  name            = var.lbs_name
  data_factory_id = azurerm_data_factory.rg.id

  service_endpoint     = "https://example.blob.core.windows.net"
  service_principal_id = "00000000-0000-0000-0000-000000000000"
  tenant_id            = "00000000-0000-0000-0000-000000000000"
  service_principal_linked_key_vault_key {
    linked_service_name = azurerm_data_factory_linked_service_key_vault.rg.name
    secret_name         = var.secret_name 
  }
}

resource "azurerm_data_factory_integration_runtime_self_hosted" "rg" {
  name            = var.self_ir_name 
  data_factory_id = azurerm_data_factory.rg.id
#   virtual_network_enabled = "true"
}
resource "azurerm_data_factory_pipeline" "rg" {
  name            = var.adf_pipeline_name 
  data_factory_id = azurerm_data_factory.rg.id
  variables = {
    "bob" = "item1"
  }
  activities_json = <<JSON
[
    {
        "name": "Append variable1",
        "type": "AppendVariable",
        "dependsOn": [],
        "userProperties": [],
        "typeProperties": {
            "variableName": "bob",
            "value": "something"
        }
    }
]
  JSON
}

resource "azurerm_data_factory_trigger_schedule" "rg" {
  name            = "triggerADF"
  data_factory_id = azurerm_data_factory.rg.id
  pipeline_name   = azurerm_data_factory_pipeline.rg.name

  interval  = 5
  frequency = "Day"
}