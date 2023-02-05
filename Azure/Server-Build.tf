# Server Build Script - Linux
# Unknown values are placeholders
# anything labeled xxx is a placeholder

# Sets the Azure provider and version of Terraform being used
# Check Terraform docs as version 3.0.0 might be outdated
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider This will change if using AWS or GCP or any other cloud provider
# Subscription_ID flags are used to specify subscription you use for example you could have different environments for test, dev and production

provider "azurerm" {
  subscription_id = "xxxxxxxxxxx"

  features {}
}

# Create a resource group  name is the name of the resource group and location  ( the location depends on what region you wish to use )
# Unknown is a placeholder please populate with correct values
resource "azurerm_resource_group" "xx" {
  name     = "xx"
  location = "UK South"
  tags = {
    Environment   = "Unknown"
    Application   = "Unknown"
    Business_Unit = "Unknown"
    Criticality   = "Unknown"
    Location      = "AZU"
    Owner         = "Unknown"
    project       = "Unknown"

  }
}
#Creates a  virtual Network
# Line 45 & 45 links the script to the resource group we provisioned using .resource-group-name and .location/name
#Adress Space can be changed to whatever subnet you require
resource "azurerm_virtual_network" "demo-vn" {
  name                = "demo-vn"
  location            = azurerm_resource_group.xx.location
  resource_group_name = azurerm_resource_group.xx.name
  address_space       = ["xx.xx.xx.xx/24"]


  tags = {
    Environment   = "Unknown"
    Application   = "Unknown"
    Business_Unit = "Unknown"
    Criticality   = "Unknown"
    Location      = "AZU"
    Owner         = "Unknown"
    project       = "Unknown"
  }
}

# Creates a subnet within the virtual network
# line 64 links to previously created rg
resource "azurerm_subnet" "Terraform-subnet" {
  name                 = "Terraform-subnet"
  resource_group_name  = azurerm_resource_group.xx.name
  virtual_network_name = azurerm_virtual_network.demo-vn.name
  address_prefixes     = ["xx.xx.xx.xx/24"]
}

# creates a security group within our resource group we created earlier
resource "azurerm_network_security_group" "Demo-sc-group" {
  name                = "Demo-sc-group"
  location            = azurerm_resource_group.xx.location
  resource_group_name = azurerm_resource_group.xx.name
# Creates an inbound security rule to allow us to connect to our vm
  security_rule {
    name                       = "developer-access"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
  ## Add your static Ip Adress here for added security( Remember to use a mask of /32)
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name        =  azurerm_resource_group.xx.name
  network_security_group_name  = azurerm_network_security_group.Demo-sc-group.name
    
    
  }

  tags = {
    Environment   = "Unknown"
    Application   = "Unknown"
    Business_Unit = "Unknown"
    Criticality   = "Unknown"
    Location      = "AZU"
    Owner         = "Unknown"
    project       = "Unknown"
  }
}
# Associates the Security group with the subnet we created earlier
resource "azurerm_subnet_network_security_group_association" "demo-sga" {
  subnet_id                 = azurerm_subnet.Terraform-subnet.id
  network_security_group_id = azurerm_network_security_group.Demo-sc-group.id
}
#Creates a Public IP 
resource "azurerm_public_ip" "demo-ip" {
  name                = "demo-ip"
  resource_group_name = azurerm_resource_group.xx.name
  location            = azurerm_resource_group.xx.location
 ##  Sets a dynamically assigned IP 
 ### Worth noting Ip address will not show up untill attached to a resource
  allocation_method   = "Dynamic"

  tags = {
    Environment   = "Unknown"
    Application   = "Unknown"
    Business_Unit = "Unknown"
    Criticality   = "Unknown"
    Location      = "AZU"
    Owner         = "Unknown"
    project       = "Unknown"
  }
}

# Crestes a nic within the resource group
resource "azurerm_network_interface" "demo-nic" {
  name                = "demo-nic"
  location            = azurerm_resource_group.xx.location
  resource_group_name = azurerm_resource_group.xx.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.demo.id
    private_ip_address_allocation = "Dynamic"
    # links to public IP we previously created
    public_ip_address_id          = azurerm_public_ip.demo-ip.id
     }
    tags = {
    Environment   = "Unknown"
    Application   = "Unknown"
    Business_Unit = "Unknown"
    Criticality   = "Unknown"
    Location      = "AZU"
    project       = "Unknown"
    }

}
# Creates a linux virual machine
resource "azurerm_linux_virtual_machine" "demo-machine" {
  name                = "demo-machine"
  resource_group_name = azurerm_resource_group.xx.name
  location            = azurerm_resource_group.xx.location
  ## Specifies size of instance
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
  azurerm_network_interface.demo-nic.id,
  ]
## Creats a SSH Keypair so we can SSH into  the server
### Run  ssh-keygen -t rsa  in terminal to generate the rsa keypair
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/demo-key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
## Specifies we want to spin up an ubuntu server on version 16.04-LTS ( This can be changed depending on what version of linux you want to run)
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
   tags = {
    Environment   = "Unknown"
    Application   = "Unknown"
    Business_Unit = "Unknown"
    Criticality   = "Unknown"
    Location      = "AZU"
    Owner         = "Unknown"
    project       = "Unknown"
    }
}





