resource "azurerm_network_interface" "linux_vm" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_allocation
    public_ip_address_id          = var.create_public_ip ? azurerm_public_ip.linux_vm[0].id : null
  }

  tags = var.tags
}

resource "azurerm_public_ip" "linux_vm" {
  count               = var.create_public_ip ? 1 : 0
  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_allocation
  sku                 = var.public_ip_sku
  tags                = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                            = var.name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids           = concat([azurerm_network_interface.linux_vm.id], var.additional_network_interface_ids)
  computer_name                   = var.name
  custom_data                     = var.custom_data
  user_data                       = var.user_data
  zone                            = var.availability_zone
  provision_vm_agent              = var.provision_vm_agent
  allow_extension_operations      = var.allow_extension_operations
  encryption_at_host_enabled      = var.encryption_at_host_enabled


  dynamic "os_disk" {
    for_each = var.os_disk != null ? [1] : []
    content {
      caching                   = var.os_disk.caching
      storage_account_type      = var.os_disk.storage_account_type
      name                      = "${var.name}-osdisk"
      disk_encryption_set_id    = var.os_disk.disk_encryption_set_id
      write_accelerator_enabled = var.os_disk.write_accelerator_enabled
    }
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  dynamic "identity" {
    for_each = var.identity != null ? [1] : []
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  dynamic "admin_ssh_key" {

    for_each = var.ssh_public_key != null ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.ssh_public_key
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_uri != null ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics_storage_uri
    }
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "custom_script" {
  count                = var.custom_script_command != null ? 1 : 0
  name                 = "${var.name}-cse"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings = jsonencode({
    "commandToExecute" = var.custom_script_command
  })
}

resource "azurerm_monitor_diagnostic_setting" "linux_vm" {
  count              = var.enable_diagnostics ? 1 : 0
  name               = "${var.name}-diagnostic"
  target_resource_id = azurerm_linux_virtual_machine.linux_vm.id

  storage_account_id             = local.storage_id
  log_analytics_workspace_id     = local.log_analytics_id
  log_analytics_destination_type = local.log_analytics_destination_type
  eventhub_authorization_rule_id = local.eventhub_authorization_rule_id
  eventhub_name                  = local.eventhub_name

  dynamic "enabled_log" {
    for_each = local.log_categories

    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = local.metrics

    content {
      category = metric.key
      enabled  = metric.value.enabled
    }
  }
}
