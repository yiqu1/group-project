terraform {
  backend "azurerm" {
    resource_group_name  = "1-00cd200b-playground-sandbox"
    storage_account_name = "fdmgroupproject11"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}
