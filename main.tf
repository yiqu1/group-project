# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Create 3 subnets
resource "azurerm_subnet" "subnet" {
  count               = length(var.subnet_names)
  name                = var.subnet_names[count.index]
  resource_group_name = var.resource_group_name
  virtual_network_name= var.virtual_network_name
  address_prefixes    = ["10.0.${count.index}.0/24"]
}

# Create a public IP address
resource "azurerm_public_ip" "publicip11" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku = "Standard"
}

# Create a Load Balancer
resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku = "Standard"

  frontend_ip_configuration {
    name                 = "myfrontendip"
    public_ip_address_id = azurerm_public_ip.publicip11.id
  }
}
