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
