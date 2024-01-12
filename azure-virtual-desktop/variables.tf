variable "create_resource_group" {
  description = "Set this to true if a new RG is required."
  type        = bool
  default     = false
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "resource_group_name" {
  type    = string
  default = null
}

variable "workspace" {
  type = map(object({
    name                      = string
    friendly_name             = optional(string)
    description               = optional(string)
    diagnostics_settings_name = optional(string)
    log_categories            = optional(list(string))
    retention_days            = optional(number)
  }))
}

variable "hostpool" {
  type = map(object({
    name                             = string
    friendly_name                    = optional(string)
    description                      = optional(string)
    validate_environment             = optional(bool)
    start_vm_on_connect              = optional(bool)
    custom_rdp_properties            = optional(string)
    personal_desktop_assignment_type = optional(string) # When the Hostpool type is 'Personal'. Possible values are Automatic and Direct.
    preferred_app_group_type         = optional(string) # Valid options are None, Desktop or RailApplications. Default is None.
    type                             = string
    maximum_sessions_allowed         = optional(number)
    load_balancer_type               = string # Possible values are BreadthFirst, DepthFirst and Persistent.
    expiration_date                  = string
    diagnostics_settings_name        = optional(string)
    log_categories                   = optional(list(string))
    retention_days                   = optional(number)
    scheduled_agent_updates = optional(object({
      enabled                   = bool
      timezone                  = optional(string)
      use_session_host_timezone = optional(string)

      schedule = optional(object({
        day_of_week = optional(string)
        hour_of_day = optional(number)
      }))
    }))
  }))
  default = {}
}

variable "dag" {
  type = map(object({
    hostpool_key              = string
    workspace_key             = string
    type                      = string
    name                      = string
    friendly_name             = optional(string)
    description               = optional(string)
    diagnostics_settings_name = optional(string)
    log_categories            = optional(list(string))
    retention_days            = optional(number)
  }))
}

variable "avd_application" {
  default = {}
  type = map(object({
    dag_key                      = string
    name                         = string
    command_line_argument_policy = string #allowed values are DoNotAllow, Allow, Required
    friendly_name                = optional(string)
    description                  = optional(string)
    path                         = optional(string) #application path
    icon_path                    = optional(string)
  }))
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "vm_names" {
  type = map(object({
    name         = string
    zones        = optional(string)
    hostpool_key = string
  }))
  default = {}
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
  default     = null
}

variable "subnet_name" {
  description = "The name of the subnet to use in VM scale set"
  type        = string
  default     = null
}

variable "virtual_network_rg" {
  description = "RG name where the Virtual Network resides"
  type        = string
  default     = null
}

variable "storage_account_rg" {
  description = "RG name where the Storage account resides"
  type        = string
  default     = null
}

variable "storage_account_name" {
  description = "RG name where the Storage account resides"
  type        = string
  default     = null
}

variable "key_vault_name" {
  description = "Specify the name of the KV that has the customer managed key stored"
  type        = string
  default     = null
}

variable "key_vault_rg_name" {
  description = "RG name of the KV with customer managed key"
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "List of dns servers to use for network interface"
  default     = []
  type        = list(string)
}

variable "enable_ip_forwarding" {
  description = "Should IP Forwarding be enabled? Defaults to false"
  type        = bool
  default     = false
}

variable "enable_accelerated_networking" {
  description = "Should Accelerated Networking be enabled? Defaults to false."
  type        = bool
  default     = true
}

variable "internal_dns_name_label" {
  description = "The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network."
  default     = null
  type        = string
}

variable "private_ip_address_allocation_type" {
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  default     = "Dynamic"
  type        = string
}

variable "enable_proximity_placement_group" {
  type    = bool
  default = false
}

variable "enable_vm_availability_set" {
  type    = bool
  default = false
}

variable "platform_fault_domain_count" {
  description = "Specifies the number of fault domains that are used"
  type        = number
  default     = 3
}

variable "platform_update_domain_count" {
  description = "Specifies the number of update domains that are used"
  type        = number
  default     = 5
}

variable "virtual_machine_size" {
  description = "The Virtual Machine SKU for the Virtual Machine, Default is Standard_A2_V2"
  default     = "Standard_D8s_v3"
  type        = string
}

variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine."
  default     = "azureadmin"
  type        = string
}

variable "source_image_id" {
  description = "The ID of an Image which each Virtual Machine should be based on"
  default     = null
  type        = string
}

variable "dedicated_host_id" {
  description = "The ID of a Dedicated Host where this machine should be run on."
  default     = null
  type        = string
}

variable "custom_data" {
  description = "Base64 encoded file of a bash script that gets run once by cloud-init upon VM creation"
  default     = null
  type        = any
}

variable "enable_automatic_updates" {
  description = "Specifies if Automatic Updates are Enabled for the Windows Virtual Machine."
  type        = bool
  default     = false
}

variable "enable_encryption_at_host" {
  description = " Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  default     = false
  type        = bool
}

variable "patch_mode" {
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`"
  default     = "Manual"
  type        = string
}

variable "license_type" {
  description = "Specifies the type of on-premise license which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
  default     = "None"
  type        = string
}

variable "vm_time_zone" {
  description = "Specifies the Time Zone which should be used by the Virtual Machine"
  default     = null
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS."
  default     = "Premium_ZRS"
  type        = string
}

variable "os_disk_caching" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`"
  default     = "ReadWrite"
  type        = string
}

variable "disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault"
  default     = null
  type        = string
}

variable "disk_size_gb" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  default     = null
  type        = number
}

variable "enable_os_disk_write_accelerator" {
  description = "Should Write Accelerator be Enabled for this OS Disk? This requires that the `storage_account_type` is set to `Premium_LRS` and that `caching` is set to `None`."
  default     = false
  type        = bool
}

variable "enable_ultra_ssd_data_disk_storage_support" {
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine"
  default     = false
  type        = bool
}

variable "managed_identity_type" {
  description = "The type of Managed Identity which should be assigned to the Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`"
  default     = null
  type        = string
}

variable "managed_identity_ids" {
  description = "A list of User Managed Identity ID's which should be assigned to the Virtual Machine."
  default     = null
  type        = list(string)
}

variable "enable_boot_diagnostics" {
  description = "Should the boot diagnostics enabled? Boot Diagnostics supports Standard_GRS,Standard_LRS,Standard_RAGRS storage account types."
  default     = false
  type        = bool
}

variable "winrm_protocol" {
  description = "Specifies the protocol of winrm listener. Possible values are `Http` or `Https`"
  default     = null
  type        = string
}

variable "key_vault_certificate_secret_url" {
  description = "The Secret URL of a Key Vault Certificate, which must be specified when `protocol` is set to `Https`"
  default     = null
  type        = string
}

variable "additional_unattend_content" {
  description = "The XML formatted content that is added to the unattend.xml file for the specified path and component."
  default     = null
  type        = any
}

variable "additional_unattend_content_setting" {
  description = "The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`"
  default     = null
  type        = string
}

variable "storage_account_uri" {
  description = "The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. Passing a `null` value will utilize a Managed Storage Account to store Boot Diagnostics."
  default     = null
  type        = string
}

variable "custom_image" {
  description = "Provide the custom image to this module if the default variants are not sufficient"
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
  default = null
}

variable "windows_distribution_list" {
  description = "Pre-defined Azure Windows VM images list"
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))

  default = {
    win10-21h2-pro = {
      publisher = "MicrosoftWindowsDesktop"
      offer     = "Windows-10"
      sku       = "win10-21h2-pro"
      version   = "latest"
    },

    win10-22h2-avd = {
      publisher = "MicrosoftWindowsDesktop"
      offer     = "Windows-10"
      sku       = "win10-22h2-avd"
      version   = "latest"
    },

    win10-19h2-pro-g2 = {
      publisher = "MicrosoftWindowsDesktop"
      offer     = "windows-10"
      sku       = "19h2-pro-g2"
      version   = "latest"
    },

    win11-22h2-avd = {
      publisher = "MicrosoftWindowsDesktop"
      offer     = "windows-11"
      sku       = "win11-22h2-avd"
      version   = "latest"
    }
  }
}

variable "windows_distribution_name" {
  default     = "win10-21h2-pro"
  type        = string
  description = "Variable to pick an OS flavour for Windows based VM. Possible values include: winserver, wincore, winsql"
}

variable "proximity_group_name" {
  type    = string
  default = null
}

variable "vm_availability_set_name" {
  default = null
  type    = string
}

variable "create_des" {
  type    = bool
  default = false
}

variable "key_vault_key_name" {
  default = null
  type    = string
}

variable "create_new_encryption_key" {
  type    = bool
  default = false
}

variable "des_name" {
  default = null
  type    = string
}

variable "des_encryption_type" {
  default = null
  type    = string
}

variable "auto_key_rotation_enabled" {
  type    = bool
  default = false
}

variable "des_kv_role_definition" {
  default = null
  type    = string
}

variable "domain_name" {
  default = null
  type    = string
}

variable "ou_path" {
  default = null
  type    = string
}

variable "service_account_kv_secret_name" {
  default = null
  type    = string
}

variable "service_account_password_kv_secret_name" {
  default = null
  type    = string
}

variable "artifacts_location" {
  description = "Location/Path of the script to be run."
  type        = string
  default     = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_09-08-2022.zip"
}

variable "enable_diagnostics" {
  type    = bool
  default = false
}

variable "enable_new_relic" {
  description = "Enable New Relic Monitoring agent installation on VMs"
  default     = false
  type        = bool
}

variable "new_relic_api_key_kv_secret_name" {
  type    = string
  default = null
}

variable "script_path" {
  type    = string
  default = "newrelic.ps1"
}

variable "enable_vm_diagnostics" {
  default = false
  type    = bool
}

variable "logs_destinations_ids" {
  type    = list(string)
  default = []
}