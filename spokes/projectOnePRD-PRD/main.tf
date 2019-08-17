terraform {
  backend "azurerm" {
    resource_group_name         = "Enterprise-RG"
    storage_account_name        = "msenterpriseprd"
    container_name              = "tfstate"
    key                         = "projectone.tfstate"
  }
}
resource "azurerm_resource_group" "projectOne" {
    name = "M-ProjectOnePRD-RG"
    location = "UK South"
}