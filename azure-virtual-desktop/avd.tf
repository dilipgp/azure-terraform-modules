#---------------------------------
# Local declarations
#---------------------------------
locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp[*].name, azurerm_resource_group.rg[*].name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp[*].location, azurerm_resource_group.rg[*].location, [""]), 0)
}

#---------------------------------------------------------
# Resource Group Creation or selection - Default is "false"
#----------------------------------------------------------
data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group ? 0 : 1
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
  tags     = var.tags
}

#-----------------------------------------------------
# Data Sources
#-----------------------------------------------------
data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_rg == null ? local.resource_group_name : var.virtual_network_rg
}

data "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

data "azurerm_storage_account" "storeacc" {
  count               = var.enable_boot_diagnostics || var.enable_vm_diagnostics ? 1 : 0
  name                = var.storage_account_name
  resource_group_name = var.storage_account_rg == null ? local.resource_group_name : var.storage_account_rg
}

data "azurerm_key_vault" "kv" {
  count               = var.key_vault_name != null ? 1 : 0
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name == null ? local.resource_group_name : var.key_vault_rg_name
}

data "azurerm_key_vault_key" "kv_key" {
  count        = var.create_new_encryption_key ? 0 : 1
  name         = var.key_vault_key_name
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

data "azurerm_key_vault_secret" "service_account_kv_secret" {
  name         = var.service_account_kv_secret_name
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

data "azurerm_key_vault_secret" "service_account_password_kv_secret" {
  name         = var.service_account_password_kv_secret_name
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

data "azurerm_key_vault_secret" "new_relic_api_key_secret" {
  count        = var.enable_new_relic ? 1 : 0
  name         = var.new_relic_api_key_kv_secret_name
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

#----------------------------------------------------------
# Key Vault Secret & Random Password Resource
#----------------------------------------------------------
resource "random_password" "passwd" {
  for_each    = var.vm_names
  length      = 12
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2
  special     = true

  keepers = {
    admin_password = each.key
  }
}

resource "azurerm_key_vault_secret" "vmpassword" {
  for_each     = var.vm_names
  name         = "${each.value["name"]}-password"
  value        = random_password.passwd[each.key].result
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

resource "azurerm_key_vault_key" "des_key" {
  count        = var.create_new_encryption_key ? 1 : 0
  name         = var.key_vault_key_name
  key_vault_id = data.azurerm_key_vault.kv[0].id
  key_type     = "RSA"
  key_size     = 4096
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
}

#-----------------------------------------------------
# Create AVD workspace
#-----------------------------------------------------
resource "azurerm_virtual_desktop_workspace" "workspace" {
  for_each            = var.workspace
  name                = each.value["name"]
  resource_group_name = local.resource_group_name
  location            = local.location
  friendly_name       = each.value["friendly_name"]
  description         = each.value["description"]
}

#-----------------------------------------------------
# Create AVD Hostpool
#-----------------------------------------------------
resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  for_each                         = var.hostpool
  resource_group_name              = local.resource_group_name
  location                         = local.location
  name                             = each.value["name"]
  friendly_name                    = each.value["friendly_name"]
  validate_environment             = each.value["validate_environment"]
  start_vm_on_connect              = each.value["start_vm_on_connect"]
  custom_rdp_properties            = each.value["custom_rdp_properties"]
  personal_desktop_assignment_type = each.value["personal_desktop_assignment_type"] # When the Hostpool type is 'Personal'
  preferred_app_group_type         = each.value["preferred_app_group_type"]
  description                      = each.value["description"]
  type                             = each.value["type"]
  maximum_sessions_allowed         = each.value["maximum_sessions_allowed"]
  load_balancer_type               = each.value["load_balancer_type"]

  dynamic "scheduled_agent_updates" {
    for_each = can(each.value.scheduled_agent_updates) ? [each.value.scheduled_agent_updates] : []
    content {
      enabled                   = scheduled_agent_updates.value.enabled
      timezone                  = scheduled_agent_updates.value.timezone
      use_session_host_timezone = scheduled_agent_updates.value.use_session_host_timezone

      dynamic "schedule" {
        for_each = scheduled_agent_updates.value.enabled ? [scheduled_agent_updates.value] : []
        content {
          day_of_week = schedule.value.day_of_week
          hour_of_day = schedule.value.hour_of_day
        }
      }
    }
  }

  tags = lookup(each.value, "tags", null)
}

#-----------------------------------------------------
# Generate an AVD Hostpool Token
#-----------------------------------------------------
resource "azurerm_virtual_desktop_host_pool_registration_info" "avd_token" {
  for_each        = var.hostpool
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool[each.key].id
  expiration_date = each.value["expiration_date"]
  depends_on      = [azurerm_virtual_desktop_host_pool.hostpool]
}

resource "azurerm_key_vault_secret" "session_host_token" {
  for_each     = var.hostpool
  name         = "${each.value["name"]}-token"
  value        = azurerm_virtual_desktop_host_pool_registration_info.avd_token[each.key].token
  key_vault_id = data.azurerm_key_vault.kv[0].id
}

#-----------------------------------------------------
# Create AVD Application Group
#-----------------------------------------------------
resource "azurerm_virtual_desktop_application_group" "dag" {
  for_each            = var.dag
  resource_group_name = local.resource_group_name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool[each.value["hostpool_key"]].id
  location            = local.location
  type                = each.value["type"]
  name                = each.value["name"]
  friendly_name       = each.value["friendly_name"]
  description         = each.value["description"]
  depends_on = [
    azurerm_virtual_desktop_host_pool.hostpool
  ]
}

resource "azurerm_virtual_desktop_application" "this" {
  for_each                     = var.avd_application
  name                         = each.value["name"]
  application_group_id         = azurerm_virtual_desktop_application_group.dag[each.value["dag_key"]].id
  friendly_name                = each.value["friendly_name"]
  description                  = each.value["description"]
  command_line_argument_policy = each.value["command_line_argument_policy"]
  path                         = each.value["path"]
  show_in_portal               = true
  icon_path                    = each.value["icon_path"]
  icon_index                   = 0
  depends_on = [
    azurerm_virtual_desktop_application_group.dag
  ]
}


#-----------------------------------------------------
# Associate AVD Workspace and Application Group
#-----------------------------------------------------
resource "azurerm_virtual_desktop_workspace_application_group_association" "this" {
  for_each             = var.dag
  application_group_id = azurerm_virtual_desktop_application_group.dag[each.key].id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace[each.value["workspace_key"]].id
  depends_on = [
    azurerm_virtual_desktop_workspace.workspace, azurerm_virtual_desktop_application_group.dag
  ]
}

#---------------------------------------
# Network Interface for Virtual Machine
#---------------------------------------
resource "azurerm_network_interface" "nic" {
  for_each                      = var.vm_names
  name                          = "${each.value["name"]}-nic"
  resource_group_name           = local.resource_group_name
  location                      = local.location
  dns_servers                   = var.dns_servers
  enable_ip_forwarding          = var.enable_ip_forwarding
  enable_accelerated_networking = var.enable_accelerated_networking
  internal_dns_name_label       = var.internal_dns_name_label
  tags                          = var.tags

  ip_configuration {
    name                          = "${each.value["name"]}-ipconfig"
    primary                       = true
    subnet_id                     = data.azurerm_subnet.snet.id
    private_ip_address_allocation = var.private_ip_address_allocation_type
  }
}

#----------------------------------------------------------------------------------------------------
# Proximity placement group for virtual machines, virtual machine scale sets and availability sets.
#----------------------------------------------------------------------------------------------------
resource "azurerm_proximity_placement_group" "appgrp" {
  count               = var.enable_proximity_placement_group ? 1 : 0
  name                = var.proximity_group_name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = var.tags
}

#-----------------------------------------------------
# Manages an Availability Set for Virtual Machines.
#-----------------------------------------------------
resource "azurerm_availability_set" "av_set" {
  count                        = var.enable_vm_availability_set ? 1 : 0
  name                         = var.vm_availability_set_name
  resource_group_name          = local.resource_group_name
  location                     = local.location
  platform_fault_domain_count  = var.platform_fault_domain_count
  platform_update_domain_count = var.platform_update_domain_count
  proximity_placement_group_id = var.enable_proximity_placement_group ? azurerm_proximity_placement_group.appgrp[0].id : null
  managed                      = true
  tags                         = var.tags
}

#---------------------------------------
# Windows Virutal machine
#---------------------------------------
resource "azurerm_windows_virtual_machine" "win_vm" {
  for_each                     = var.vm_names
  name                         = each.value["name"]
  computer_name                = each.value["name"]
  resource_group_name          = local.resource_group_name
  location                     = local.location
  size                         = var.virtual_machine_size
  admin_username               = var.admin_username
  admin_password               = random_password.passwd[each.key].result
  network_interface_ids        = [azurerm_network_interface.nic[each.key].id]
  source_image_id              = var.source_image_id != null ? var.source_image_id : null
  provision_vm_agent           = true
  allow_extension_operations   = true
  dedicated_host_id            = var.dedicated_host_id
  custom_data                  = var.custom_data != null ? var.custom_data : null
  enable_automatic_updates     = var.enable_automatic_updates
  license_type                 = var.license_type
  availability_set_id          = var.enable_vm_availability_set == true ? element(concat(azurerm_availability_set.av_set[*].id, [""]), 0) : null
  encryption_at_host_enabled   = var.enable_encryption_at_host
  proximity_placement_group_id = var.enable_proximity_placement_group ? azurerm_proximity_placement_group.appgrp[0].id : null
  patch_mode                   = var.patch_mode
  zone                         = each.value["zones"]
  timezone                     = var.vm_time_zone
  tags                         = var.tags
  depends_on                   = [azurerm_role_assignment.des_kv_role]

  dynamic "source_image_reference" {
    for_each = var.source_image_id != null ? [] : [1]
    content {
      publisher = var.custom_image != null ? var.custom_image["publisher"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["publisher"]
      offer     = var.custom_image != null ? var.custom_image["offer"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["offer"]
      sku       = var.custom_image != null ? var.custom_image["sku"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["sku"]
      version   = var.custom_image != null ? var.custom_image["version"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["version"]
    }
  }

  os_disk {
    storage_account_type      = var.os_disk_storage_account_type
    caching                   = var.os_disk_caching
    disk_encryption_set_id    = var.disk_encryption_set_id != null ? var.disk_encryption_set_id : (var.create_des ? azurerm_disk_encryption_set.des[0].id : null)
    disk_size_gb              = var.disk_size_gb
    write_accelerator_enabled = var.enable_os_disk_write_accelerator
    name                      = "${each.value["name"]}-osdisk"
  }

  additional_capabilities {
    ultra_ssd_enabled = var.enable_ultra_ssd_data_disk_storage_support
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? var.managed_identity_ids : null
    }
  }

  dynamic "winrm_listener" {
    for_each = var.winrm_protocol != null ? [1] : []
    content {
      protocol        = var.winrm_protocol
      certificate_url = var.winrm_protocol == "Https" ? var.key_vault_certificate_secret_url : null
    }
  }

  dynamic "additional_unattend_content" {
    for_each = var.additional_unattend_content != null ? [1] : []
    content {
      content = var.additional_unattend_content
      setting = var.additional_unattend_content_setting
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? [1] : []
    content {
      storage_account_uri = var.storage_account_uri != null ? var.storage_account_uri : (var.storage_account_name != null ? data.azurerm_storage_account.storeacc[0].primary_blob_endpoint : null)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

#-------------------------------------------------------------------------
# Disk encryption set, Key Vault Role Assignment
#-------------------------------------------------------------------------
resource "azurerm_disk_encryption_set" "des" {
  count                     = var.create_des ? 1 : 0
  name                      = var.des_name
  resource_group_name       = local.resource_group_name
  location                  = local.location
  key_vault_key_id          = var.create_new_encryption_key ? azurerm_key_vault_key.des_key[0].id : data.azurerm_key_vault_key.kv_key[0].id
  encryption_type           = var.des_encryption_type
  auto_key_rotation_enabled = var.auto_key_rotation_enabled

  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_role_assignment" "des_kv_role" {
  count                            = var.create_des ? 1 : 0
  scope                            = data.azurerm_key_vault.kv[0].id
  role_definition_name             = var.des_kv_role_definition
  principal_id                     = azurerm_disk_encryption_set.des[0].identity[0].principal_id
  skip_service_principal_aad_check = true
  depends_on                       = [azurerm_disk_encryption_set.des]
}

#-------------------------------------------------------------------------
# Azure VM Extension to Domain Join VMs
#-------------------------------------------------------------------------
resource "azurerm_virtual_machine_extension" "domain_join" {
  for_each             = var.vm_names
  name                 = "${each.value["name"]}-domain-join"
  virtual_machine_id   = azurerm_windows_virtual_machine.win_vm[each.key].id
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.3"
  depends_on           = [azurerm_virtual_machine_extension.new_relic_ext]

  settings = <<SETTINGS
    {
        "Name": "${var.domain_name}",
        "User": "${data.azurerm_key_vault_secret.service_account_kv_secret.value}",
        "OUPath" : "${var.ou_path}",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
        "Password": "${data.azurerm_key_vault_secret.service_account_password_kv_secret.value}"
    }
PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }
}

#------------------------------------------
# Register Session Hosts using Extensions
#------------------------------------------
resource "azurerm_virtual_machine_extension" "register_session_host" {
  for_each                   = var.vm_names
  name                       = "${each.value["name"]}-register-session-host"
  virtual_machine_id         = azurerm_windows_virtual_machine.win_vm[each.key].id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true
  settings                   = <<SETTINGS
    {
        "ModulesUrl": "${var.artifacts_location}",
        "ConfigurationFunction" : "Configuration.ps1\\AddSessionHost",
        "Properties": {
            "hostPoolName": "${azurerm_virtual_desktop_host_pool.hostpool[each.value["hostpool_key"]].name}",
            "aadJoin": true
        }
    }
    SETTINGS
  protected_settings         = <<PROTECTED_SETTINGS
    {
      "properties" : {
            "registrationInfoToken" : "${azurerm_key_vault_secret.session_host_token[each.value["hostpool_key"]].value}"
        }
    }
    PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }

  depends_on = [azurerm_virtual_machine_extension.domain_join]
}

#-------------------------------------------------------------------------
# Custom Script Extension for agent installation
#-------------------------------------------------------------------------
resource "azurerm_virtual_machine_extension" "new_relic_ext" {
  for_each             = var.enable_new_relic ? var.vm_names : {}
  name                 = "${each.value["name"]}-nr-ext"
  virtual_machine_id   = azurerm_windows_virtual_machine.win_vm[each.key].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  protected_settings = <<SETTINGS
{
  "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.script[0].rendered)}')) | Out-File -filepath newrelic.ps1\" && powershell -ExecutionPolicy Unrestricted -File newrelic.ps1 -NR_API_KEY ${data.template_file.script[0].vars.NR_API_KEY}"
 }
SETTINGS

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }
}

data "template_file" "script" {
  count    = var.enable_new_relic ? 1 : 0
  template = file(var.script_path)
  vars = {
    NR_API_KEY = data.azurerm_key_vault_secret.new_relic_api_key_secret[0].value
  }
}

#--------------------------------------------------------------
# AVD Diagnostics Settings
#--------------------------------------------------------------
module "hostpool_diagnostics" {
  for_each                  = var.enable_diagnostics ? var.hostpool : {}
  source                    = "../terraform-azure-diagnostics-settings"
  resource_id               = azurerm_virtual_desktop_host_pool.hostpool[each.key].id
  diagnostics_settings_name = each.value["diagnostics_settings_name"]
  logs_destinations_ids     = var.logs_destinations_ids
  depends_on                = [azurerm_virtual_desktop_host_pool.hostpool]
}

module "workspace_diagnostics" {
  for_each                  = var.enable_diagnostics ? var.workspace : {}
  source                    = "../terraform-azure-diagnostics-settings"
  resource_id               = azurerm_virtual_desktop_workspace.workspace[each.key].id
  diagnostics_settings_name = each.value["diagnostics_settings_name"]
  logs_destinations_ids     = var.logs_destinations_ids
  depends_on                = [azurerm_virtual_desktop_workspace.workspace]
}

module "dag_diagnostics" {
  for_each                  = var.enable_diagnostics ? var.dag : {}
  source                    = "../terraform-azure-diagnostics-settings"
  resource_id               = azurerm_virtual_desktop_application_group.dag[each.key].id
  diagnostics_settings_name = each.value["diagnostics_settings_name"]
  logs_destinations_ids     = var.logs_destinations_ids
  depends_on                = [azurerm_virtual_desktop_application_group.dag]
}

#-------------------------------------------------------------------------
# Enable diagnostic settings for Windows VM
#-------------------------------------------------------------------------
resource "azurerm_virtual_machine_extension" "diagnostics_windows" {
  for_each                   = var.enable_vm_diagnostics ? var.vm_names : {}
  name                       = "${each.value.name}-ds-ext"
  publisher                  = "Microsoft.Azure.Diagnostics"
  type                       = "IaaSDiagnostics"
  type_handler_version       = "1.16"
  auto_upgrade_minor_version = "true"
  virtual_machine_id         = azurerm_windows_virtual_machine.win_vm[each.key].id
  depends_on                 = [azurerm_virtual_machine_extension.win_monitor_agent]

  settings = templatefile(format("diagnostics.json"), {
    resource_id  = azurerm_windows_virtual_machine.win_vm[each.key].id
    storage_name = var.storage_account_name
  })

  protected_settings = jsonencode({
    "storageAccountName" : var.storage_account_name,
    "managedIdentity" : {
      "clientId" : data.azurerm_client_config.current.client_id,
      "objectId" : data.azurerm_client_config.current.object_id
    }
  })
}

resource "azurerm_virtual_machine_extension" "win_monitor_agent" {
  for_each                   = var.enable_vm_diagnostics ? var.vm_names : {}
  name                       = "${each.value.name}-mon-agent-ext"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.18"
  auto_upgrade_minor_version = "true"
  automatic_upgrade_enabled  = "true"
  virtual_machine_id         = azurerm_windows_virtual_machine.win_vm[each.key].id
  depends_on                 = [azurerm_virtual_machine_extension.new_relic_ext]
}