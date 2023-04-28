# Create a Resource Group
# resource "azurerm_resource_group" "rg" {
#   name     = var.resource_group_name
#   location = var.location
# }

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "myvirtualnetwork"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Create 3 subnets
resource "azurerm_subnet" "subnet" {
  count               = length(var.subnet_names)
  name                = var.subnet_names[count.index]
  resource_group_name = var.resource_group_name
  virtual_network_name= azurerm_virtual_network.vnet.name
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

# Create a Load Balancer backend pool
resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "mybackendpool"
}

# creates a health probe for the load balancer
resource "azurerm_lb_probe" "probe" {
  name                = "myprobe"
  loadbalancer_id     = azurerm_lb.lb.id
  port                = 80
}

#Create a Load Balancer rule
resource "azurerm_lb_rule" "rule" {
  name                           = "myloadbalancerrule"
  loadbalancer_id                = azurerm_lb.lb.id
  load_distribution              = "Default"
  frontend_ip_configuration_name = "myfrontendip"
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.pool.id]
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  probe_id                       = azurerm_lb_probe.probe.id
}

# Create a storage account
resource "azurerm_storage_account" "groupproject" {
  name                     = "fdmgroupproject11"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a container to store the tfstate file
resource "azurerm_storage_container" "terraform_state" {
  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.groupproject.name
  container_access_type = "private"
}

# Create a VM
resource "azurerm_virtual_machine" "vm" {
  name                  = "myvm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic-1.id, azurerm_network_interface.nic-2.id]
  primary_network_interface_id = azurerm_network_interface.nic-1.id
  vm_size               = "Standard_DS1_v2"
  availability_set_id = azurerm_availability_set.avset.id

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testaccount"
    admin_password = "Password123!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
