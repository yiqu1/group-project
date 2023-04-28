variable "resource_group_name" {
  description = "Name of the resource group"
  type = string
  default = "1-00cd200b-playground-sandbox"
}

variable "location" {
  type        = string
  description = "The location of the resources"
  default = "eastus"
}