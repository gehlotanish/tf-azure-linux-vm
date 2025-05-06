output "vm_id" {
  description = "The resource ID of the Linux virtual machine"
  value       = azurerm_linux_virtual_machine.linux_vm.id
}

output "vm_private_ip" {
  description = "The private IP address assigned to the VM's network interface"
  value       = azurerm_network_interface.linux_vm.private_ip_address
}

output "vm_public_ip" {
  description = "The public IP address assigned to the VM (null if not created)"
  value       = var.create_public_ip ? azurerm_public_ip.linux_vm[0].ip_address : null
}

output "vm_name" {
  description = "The name of the Linux virtual machine"
  value       = azurerm_linux_virtual_machine.linux_vm.name
}

output "vm_nic_id" {
  description = "The resource ID of the VM's network interface"
  value       = azurerm_network_interface.linux_vm.id
}

