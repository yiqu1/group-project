# Create an availability set
resource "azurerm_availability_set" "avset" {
  name                = "myavset"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Create a container to store the Virtual Machine Datas and Managed Disks
resource "azurerm_storage_container" "vm_container" {
  name                  = "vm-container"
  storage_account_name  = azurerm_storage_account.groupproject.name
  container_access_type = "private"
}

# Create a managed disk
resource "azurerm_managed_disk" "managed_disk" {
  name                 = "mydatadisk1"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "10"
  storage_account_id   = azurerm_storage_account.groupproject.id
}

# Manages attaching a Disk to a Virtual Machine.
resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {
  managed_disk_id    = azurerm_managed_disk.disk_attach.id
  virtual_machine_id = azurerm_virtual_machine.vm.id
  lun                = "10"
  caching            = "ReadWrite"
}

# Create a network interface card
resource "azurerm_network_interface" "nic-1" {
  name                = "my-nic-1"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1-frontend"
    subnet_id                     = azurerm_subnet.subnet[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nic-2" {
  name                = "my-nic-2"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1-backend"
    subnet_id                     = azurerm_subnet.subnet[1].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Association between a Network Interface and a Load Balancer's Backend Address Pool.
resource "azurerm_network_interface_backend_address_pool_association" "association1" {
  network_interface_id    = azurerm_network_interface.nic-1.id
  ip_configuration_name  = "ipconfig1-frontend"
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "association2" {
  network_interface_id    = azurerm_network_interface.nic-2.id
  ip_configuration_name  = "ipconfig1-backend"
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool.id
}
