data "azurerm_monitor_diagnostic_categories" "main" {
  count       = var.enable_diagnostics ? 1 : 0
  resource_id = azurerm_linux_virtual_machine.linux_vm.id
}
