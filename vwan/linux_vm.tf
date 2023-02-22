# Virtual Machines
#Public IPs
resource "azurerm_public_ip" "region1-linux01-pip" {
  name                = "${var.region1}-linux01-pip"
  resource_group_name = azurerm_resource_group.region1-rg1.name
  location            = var.region1
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment_tag
  }
}
resource "azurerm_public_ip" "region2-linux01-pip" {
  name                = "${var.region2}-linux01-pip"
  resource_group_name = azurerm_resource_group.region2-rg1.name
  location            = var.region2
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment_tag
  }
}
#Create NICs and associate the Public IPs
resource "azurerm_network_interface" "region1-linux01-nic" {
  name                = "${var.region1}-linux01-nic"
  location            = var.region1
  resource_group_name = azurerm_resource_group.region1-rg1.name


  ip_configuration {
    name                          = "${var.region1}-linux01-ipconfig"
    subnet_id                     = azurerm_subnet.region1-vnet1-snet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.region1-linux01-pip.id
  }

  tags = {
    Environment = var.environment_tag
  }
}
resource "azurerm_network_interface" "region2-linux01-nic" {
  name                = "${var.region2}-linux01-nic"
  location            = var.region2
  resource_group_name = azurerm_resource_group.region2-rg1.name


  ip_configuration {
    name                          = "${var.region2}-linux01-ipconfig"
    subnet_id                     = azurerm_subnet.region2-vnet1-snet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.region2-linux01-pip.id
  }

  tags = {
    Environment = var.environment_tag
  }
}
#Create VMs
resource "azurerm_linux_virtual_machine" "region1-linux01" {
  name                = "${var.region1}-linux01"
  depends_on          = [azurerm_key_vault.kv1]
  resource_group_name = azurerm_resource_group.region1-rg1.name
  location            = var.region1
  size                = var.vmsize
  admin_username      = var.adminusername
  admin_password      = azurerm_key_vault_secret.vmpassword.value
  network_interface_ids = [
    azurerm_network_interface.region1-linux01-nic.id,
  ]

  tags = {
    Environment = var.environment_tag
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
resource "azurerm_linux_virtual_machine" "region2-linux01" {
  name                = "${var.region2}-linux01"
  depends_on          = [azurerm_key_vault.kv1]
  resource_group_name = azurerm_resource_group.region2-rg1.name
  location            = var.region2
  size                = var.vmsize
  admin_username      = var.adminusername
  admin_password      = azurerm_key_vault_secret.vmpassword.value
  network_interface_ids = [
    azurerm_network_interface.region2-linux01-nic.id,
  ]

  tags = {
    Environment = var.environment_tag
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}