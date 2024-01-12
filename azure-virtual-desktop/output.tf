output "azure_virtual_desktop_host_pool_name" {
  description = "Name of the Azure Virtual Desktop host pool"
  value       = [for x in azurerm_virtual_desktop_host_pool.hostpool : x.name]
}

output "azure_virtual_desktop_host_pool_id" {
  description = "Name of the Azure Virtual Desktop host pool"
  value       = [for x in azurerm_virtual_desktop_host_pool.hostpool : x.id]
}

output "azurerm_virtual_desktop_application_group_name" {
  description = "Name of the Azure Virtual Desktop DAG"
  value       = [for x in azurerm_virtual_desktop_application_group.dag : x.name]
}

output "azurerm_virtual_desktop_workspace_name" {
  description = "Name of the Azure Virtual Desktop workspace"
  value       = [for x in azurerm_virtual_desktop_workspace.workspace : x.name]
}

output "azurerm_virtual_desktop_workspace_id" {
  value = [for x in azurerm_virtual_desktop_workspace.workspace : x.id]
}
