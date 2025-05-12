variable "name" {
  description = "Name of the Linux virtual machine and related resources (NIC, disk, etc.)"
  type        = string
}

variable "location" {
  description = "Azure region where the VM will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the VM"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the network interface will be placed"
  type        = string
}

variable "create_public_ip" {
  description = "Whether to create a public IP address for the VM"
  type        = bool
  default     = false
}

variable "private_ip_allocation" {
  description = "Private IP allocation method: Static or Dynamic"
  type        = string
  default     = "Dynamic"
}

variable "public_ip_allocation" {
  description = "Public IP allocation method: Static or Dynamic"
  type        = string
  default     = "Dynamic"
}

variable "public_ip_sku" {
  description = "SKU of the public IP: Basic or Standard"
  type        = string
  default     = "Basic"
}

variable "admin_username" {
  description = "Admin username for the Linux VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password (required if password authentication is enabled)"
  type        = string
  sensitive   = true
}

variable "disable_password_authentication" {
  description = "Disable password-based authentication for SSH"
  type        = bool
  default     = true
}

variable "ssh_public_key" {
  description = "SSH public key used for the admin user"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine (e.g., Standard_DS1_v2)"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "image" {
  description = "OS image reference for the VM"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })

  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

variable "os_disk" {
  description = "Configuration for the OS disk"
  type = object({
    caching                   = string
    storage_account_type      = string
    disk_encryption_set_id    = optional(string)
    write_accelerator_enabled = optional(bool)
  })

  default = {
    caching                   = "ReadWrite"
    storage_account_type      = "Standard_LRS"
    disk_encryption_set_id    = null
    write_accelerator_enabled = false
  }
}

variable "identity" {
  description = "Managed identity configuration"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })

  default = {
    type         = "SystemAssigned"
    identity_ids = null
  }
}

variable "availability_zone" {
  description = "Optional availability zone number (1, 2, or 3)"
  type        = number
  default     = null
}

variable "custom_data" {
  description = "Cloud-init script or configuration as a base64-encoded string"
  type        = string
  default     = null
}

variable "user_data" {
  description = "Base64-encoded user data to provide when launching the VM"
  type        = string
  default     = null
}

variable "boot_diagnostics_storage_uri" {
  description = "URI of the storage account to use for boot diagnostics"
  type        = string
  default     = null
}

variable "provision_vm_agent" {
  description = "Provision the Azure VM agent"
  type        = bool
  default     = true
}

variable "allow_extension_operations" {
  description = "Allow VM extension operations"
  type        = bool
  default     = true
}

variable "encryption_at_host_enabled" {
  description = "Enable encryption at host for the VM"
  type        = bool
  default     = false
}

variable "custom_script_command" {
  description = "Shell command to run via the Custom Script Extension after provisioning"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to all created resources"
  type        = map(string)
  default     = {}
}


variable "enable_diagnostics" {
  description = "Enable diagnostic settings for the VM"
  type        = bool
  default     = false
}

variable "log_categories" {
  type        = list(string)
  default     = null
  description = "List of log categories. Defaults to all available."
}

variable "excluded_log_categories" {
  type        = list(string)
  default     = []
  description = "List of log categories to exclude."
}

variable "metric_categories" {
  type        = list(string)
  default     = null
  description = "List of metric categories. Defaults to all available."
}

variable "logs_destinations_ids" {
  type        = list(string)
  nullable    = false
  description = <<EOD
List of destination resources IDs for logs diagnostic destination.
Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.
If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character.
EOD
}

variable "log_analytics_destination_type" {
  type        = string
  default     = "AzureDiagnostics"
  description = "When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
}
