terraform {
  backend "azurerm" {
    resource_group_name         = "EnterpriseDEV-RG"
    storage_account_name        = "msenterprisedev"
    container_name              = "tfstate"
    key                         = "projectone.tfstate"
  }
}

resource "azurerm_resource_group" "projectOne" {
    name = "M-ProjectOneUAT-RG"
    location = "UK South"
}