data "azurerm_resource_group" "example" {
  name     = "Terraform-RG"
  location = "South India"
}
data "azurerm_virtual_network" "existing_vnet" {
  name                = "example-network"
  resource_group_name = azurerm_resource_group.example.name
}
data "azurerm_subnet" "existing_subnet" {
  name                 = "internal"
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = azurerm_resource_group.example.name
}
resource "azurerm_storage_account" "storage" {
  name                     = "azhimstoaccountaqaqaq" # Must be globally unique
  resource_group_name      = "Terraform-RG"
  location                 = azurerm_resource_group.example.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action = "Deny"

    virtual_network_subnet_ids = [
      data.azurerm_subnet.existing_subnet.id
    ]
  }
}
output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}
