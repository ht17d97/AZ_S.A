data "azurerm_resource_group" "example" {
  name     = "Terraform-RG"
}
data "azurerm_virtual_network" "existing_vnet" {
  name                = "example-network"
  resource_group_name = "Terraform-RG"
}
// resource "azurerm_subnet_service_endpoint_storage_policy" "example" {
//   name                = "SA-subnet-policy"
//   resource_group_name = "Terraform-RG"
//   location            = "South India"
//   definition {
//     name        = "MS.Storage"
//     description = "testing"
//     service     = "Microsoft.Storage"
//     service_resources = [
//       azurerm_resource_group.example.id,
//       azurerm_storage_account.example.id
//     ]
//   }
// }
resource "azurerm_subnet" "example" {
  name                 = "Test-SA"
  virtual_network_name = "example-network"
  resource_group_name  = "Terraform-RG"
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints = ["Microsoft.Storage"]
}
resource "azurerm_storage_account" "storage" {
  name                     = "azhimstoaccountaqaqaq" # Must be globally unique
  resource_group_name      = "Terraform-RG"
  location                 = "South India"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action = "Deny"

    // virtual_network_subnet_ids = [
    //   data.azurerm_subnet.example.id
    // ]
  }
}
output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}
