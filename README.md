# template-terraform
Template repository for all terraform module repositories

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.27.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.27.0 |
## Modules

No modules.
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin password (required if password authentication is enabled) | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Admin username for the Linux VM | `string` | n/a | yes |
| <a name="input_allow_extension_operations"></a> [allow\_extension\_operations](#input\_allow\_extension\_operations) | Allow VM extension operations | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Optional availability zone number (1, 2, or 3) | `number` | `null` | no |
| <a name="input_boot_diagnostics_storage_uri"></a> [boot\_diagnostics\_storage\_uri](#input\_boot\_diagnostics\_storage\_uri) | URI of the storage account to use for boot diagnostics | `string` | `null` | no |
| <a name="input_create_public_ip"></a> [create\_public\_ip](#input\_create\_public\_ip) | Whether to create a public IP address for the VM | `bool` | `false` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | Cloud-init script or configuration as a base64-encoded string | `string` | `null` | no |
| <a name="input_custom_script_command"></a> [custom\_script\_command](#input\_custom\_script\_command) | Shell command to run via the Custom Script Extension after provisioning | `string` | `null` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | Disable password-based authentication for SSH | `bool` | `true` | no |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | Enable encryption at host for the VM | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | Managed identity configuration | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | <pre>{<br>  "identity_ids": null,<br>  "type": "SystemAssigned"<br>}</pre> | no |
| <a name="input_image"></a> [image](#input\_image) | OS image reference for the VM | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | <pre>{<br>  "offer": "UbuntuServer",<br>  "publisher": "Canonical",<br>  "sku": "20_04-lts",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the VM will be deployed | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the Linux virtual machine and related resources (NIC, disk, etc.) | `string` | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | Configuration for the OS disk | <pre>object({<br>    caching                   = string<br>    storage_account_type      = string<br>    disk_encryption_set_id    = optional(string)<br>    write_accelerator_enabled = optional(bool)<br>  })</pre> | <pre>{<br>  "caching": "ReadWrite",<br>  "disk_encryption_set_id": null,<br>  "storage_account_type": "Standard_LRS",<br>  "write_accelerator_enabled": false<br>}</pre> | no |
| <a name="input_private_ip_allocation"></a> [private\_ip\_allocation](#input\_private\_ip\_allocation) | Private IP allocation method: Static or Dynamic | `string` | `"Dynamic"` | no |
| <a name="input_provision_vm_agent"></a> [provision\_vm\_agent](#input\_provision\_vm\_agent) | Provision the Azure VM agent | `bool` | `true` | no |
| <a name="input_public_ip_allocation"></a> [public\_ip\_allocation](#input\_public\_ip\_allocation) | Public IP allocation method: Static or Dynamic | `string` | `"Dynamic"` | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | SKU of the public IP: Basic or Standard | `string` | `"Basic"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group in which to create the VM | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key used for the admin user | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID of the subnet where the network interface will be placed | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all created resources | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Base64-encoded user data to provide when launching the VM | `string` | `null` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of the virtual machine (e.g., Standard\_DS1\_v2) | `string` | `"Standard_DS1_v2"` | no |  
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | The resource ID of the Linux virtual machine |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | The name of the Linux virtual machine |
| <a name="output_vm_nic_id"></a> [vm\_nic\_id](#output\_vm\_nic\_id) | The resource ID of the VM's network interface |
| <a name="output_vm_private_ip"></a> [vm\_private\_ip](#output\_vm\_private\_ip) | The private IP address assigned to the VM's network interface |
| <a name="output_vm_public_ip"></a> [vm\_public\_ip](#output\_vm\_public\_ip) | The public IP address assigned to the VM (null if not created) |
<!-- END_TF_DOCS -->