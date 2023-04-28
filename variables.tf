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

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "myvirtualnetwork"
}

variable "subnet_names" {
  description = "Names of the subnets"
  type        = list(string)
  default     = ["frontend", "backend", "middle"]
}
