resource "azurerm_public_ip" "poctest2_bastionpip" {
  name                = "bastionpip"
  location            = var.region1
  resource_group_name = azurerm_resource_group.region1-rg1.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Environment = var.environment_tag
  }
}

resource "azurerm_bastion_host" "poctest2bastion" {
  name                = "poctest2bastion"
  location            = var.region1
  resource_group_name = azurerm_resource_group.region1-rg1.name
  sku                 = "Standard"
  #ip_connect_enabled  = true
  #tunneling_enabled   = true
  tags = {
    Environment = var.environment_tag
  }

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.poctest2_bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.poctest2_bastionpip.id
  }
}


resource "azurerm_network_security_group" "poctest2bastionnsg" {
  name                = "poctest2bastionnsg"
  location            = var.region1
  resource_group_name = azurerm_resource_group.region1-rg1.name
  tags = {
    Environment = var.environment_tag
  }

  security_rule {
        name                       = "GatewayManager"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "Internet-Bastion-PublicIP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "Internet"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "Internet-Bastion-AzureLoadBalancer"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "AzureLoadBalancer"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "Internet-Bastion-VirtualNetwork"
        priority                   = 1004
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_ranges     = ["8080","5701"]
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
    }
    security_rule {
        name                       = "OutboundVirtualNetwork"
        priority                   = 1001
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_ranges    = ["22","3389"]
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
    }

    security_rule {
        name                       = "OutboundVirtualNetwork02"
        priority                   = 1002
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_ranges    = ["8080","5701"]
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
    }
     security_rule {
        name                       = "OutboundToAzureCloud"
        priority                   = 1003
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
    }

     security_rule {
        name                       = "OutboundToInternet"
        priority                   = 1004
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "Internet"
    }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.poctest2_bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.poctest2bastionnsg.id
}
