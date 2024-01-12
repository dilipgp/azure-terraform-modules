<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.6, < 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.50.0, < 3.70.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.50.0, < 3.70.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dag_diagnostics"></a> [dag\_diagnostics](#module\_dag\_diagnostics) | ../terraform-azure-diagnostics-settings | n/a |
| <a name="module_hostpool_diagnostics"></a> [hostpool\_diagnostics](#module\_hostpool\_diagnostics) | ../terraform-azure-diagnostics-settings | n/a |
| <a name="module_workspace_diagnostics"></a> [workspace\_diagnostics](#module\_workspace\_diagnostics) | ../terraform-azure-diagnostics-settings | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.av_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_disk_encryption_set.des](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_key.des_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_secret.session_host_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.vmpassword](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_proximity_placement_group.appgrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/proximity_placement_group) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.des_kv_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_virtual_desktop_application.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application) | resource |
| [azurerm_virtual_desktop_application_group.dag](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_application_group) | resource |
| [azurerm_virtual_desktop_host_pool.hostpool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |
| [azurerm_virtual_desktop_host_pool_registration_info.avd_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool_registration_info) | resource |
| [azurerm_virtual_desktop_workspace.workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace) | resource |
| [azurerm_virtual_desktop_workspace_application_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_workspace_application_group_association) | resource |
| [azurerm_virtual_machine_extension.diagnostics_windows](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.domain_join](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.new_relic_ext](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.register_session_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.win_monitor_agent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.win_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.passwd](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_key.kv_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_key) | data source |
| [azurerm_key_vault_secret.new_relic_api_key_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.service_account_kv_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.service_account_password_kv_secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_resource_group.rgrp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.storeacc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [template_file.script](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_unattend_content"></a> [additional\_unattend\_content](#input\_additional\_unattend\_content) | The XML formatted content that is added to the unattend.xml file for the specified path and component. | `any` | `null` | no |
| <a name="input_additional_unattend_content_setting"></a> [additional\_unattend\_content\_setting](#input\_additional\_unattend\_content\_setting) | The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands` | `string` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator used for the Virtual Machine. | `string` | `"azureadmin"` | no |
| <a name="input_artifacts_location"></a> [artifacts\_location](#input\_artifacts\_location) | Location/Path of the script to be run. | `string` | `"https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_09-08-2022.zip"` | no |
| <a name="input_auto_key_rotation_enabled"></a> [auto\_key\_rotation\_enabled](#input\_auto\_key\_rotation\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_avd_application"></a> [avd\_application](#input\_avd\_application) | n/a | <pre>map(object({<br>    dag_key                      = string<br>    name                         = string<br>    command_line_argument_policy = string #allowed values are DoNotAllow, Allow, Required<br>    friendly_name                = optional(string)<br>    description                  = optional(string)<br>    path                         = optional(string) #application path<br>    icon_path                    = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_create_des"></a> [create\_des](#input\_create\_des) | n/a | `bool` | `false` | no |
| <a name="input_create_new_encryption_key"></a> [create\_new\_encryption\_key](#input\_create\_new\_encryption\_key) | n/a | `bool` | `false` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | Set this to true if a new RG is required. | `bool` | `false` | no |
| <a name="input_custom_data"></a> [custom\_data](#input\_custom\_data) | Base64 encoded file of a bash script that gets run once by cloud-init upon VM creation | `any` | `null` | no |
| <a name="input_custom_image"></a> [custom\_image](#input\_custom\_image) | Provide the custom image to this module if the default variants are not sufficient | <pre>map(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | `null` | no |
| <a name="input_dag"></a> [dag](#input\_dag) | n/a | <pre>map(object({<br>    hostpool_key              = string<br>    workspace_key             = string<br>    type                      = string<br>    name                      = string<br>    friendly_name             = optional(string)<br>    description               = optional(string)<br>    diagnostics_settings_name = optional(string)<br>    log_categories            = optional(list(string))<br>    retention_days            = optional(number)<br>  }))</pre> | n/a | yes |
| <a name="input_dedicated_host_id"></a> [dedicated\_host\_id](#input\_dedicated\_host\_id) | The ID of a Dedicated Host where this machine should be run on. | `string` | `null` | no |
| <a name="input_des_encryption_type"></a> [des\_encryption\_type](#input\_des\_encryption\_type) | n/a | `string` | `null` | no |
| <a name="input_des_kv_role_definition"></a> [des\_kv\_role\_definition](#input\_des\_kv\_role\_definition) | n/a | `string` | `null` | no |
| <a name="input_des_name"></a> [des\_name](#input\_des\_name) | n/a | `string` | `null` | no |
| <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id) | The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault | `string` | `null` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | List of dns servers to use for network interface | `list(string)` | `[]` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `null` | no |
| <a name="input_enable_accelerated_networking"></a> [enable\_accelerated\_networking](#input\_enable\_accelerated\_networking) | Should Accelerated Networking be enabled? Defaults to false. | `bool` | `true` | no |
| <a name="input_enable_automatic_updates"></a> [enable\_automatic\_updates](#input\_enable\_automatic\_updates) | Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. | `bool` | `false` | no |
| <a name="input_enable_boot_diagnostics"></a> [enable\_boot\_diagnostics](#input\_enable\_boot\_diagnostics) | Should the boot diagnostics enabled? Boot Diagnostics supports Standard\_GRS,Standard\_LRS,Standard\_RAGRS storage account types. | `bool` | `false` | no |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | n/a | `bool` | `false` | no |
| <a name="input_enable_encryption_at_host"></a> [enable\_encryption\_at\_host](#input\_enable\_encryption\_at\_host) | Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host? | `bool` | `false` | no |
| <a name="input_enable_ip_forwarding"></a> [enable\_ip\_forwarding](#input\_enable\_ip\_forwarding) | Should IP Forwarding be enabled? Defaults to false | `bool` | `false` | no |
| <a name="input_enable_new_relic"></a> [enable\_new\_relic](#input\_enable\_new\_relic) | Enable New Relic Monitoring agent installation on VMs | `bool` | `false` | no |
| <a name="input_enable_os_disk_write_accelerator"></a> [enable\_os\_disk\_write\_accelerator](#input\_enable\_os\_disk\_write\_accelerator) | Should Write Accelerator be Enabled for this OS Disk? This requires that the `storage_account_type` is set to `Premium_LRS` and that `caching` is set to `None`. | `bool` | `false` | no |
| <a name="input_enable_proximity_placement_group"></a> [enable\_proximity\_placement\_group](#input\_enable\_proximity\_placement\_group) | n/a | `bool` | `false` | no |
| <a name="input_enable_ultra_ssd_data_disk_storage_support"></a> [enable\_ultra\_ssd\_data\_disk\_storage\_support](#input\_enable\_ultra\_ssd\_data\_disk\_storage\_support) | Should the capacity to enable Data Disks of the UltraSSD\_LRS storage account type be supported on this Virtual Machine | `bool` | `false` | no |
| <a name="input_enable_vm_availability_set"></a> [enable\_vm\_availability\_set](#input\_enable\_vm\_availability\_set) | n/a | `bool` | `false` | no |
| <a name="input_enable_vm_diagnostics"></a> [enable\_vm\_diagnostics](#input\_enable\_vm\_diagnostics) | n/a | `bool` | `false` | no |
| <a name="input_hostpool"></a> [hostpool](#input\_hostpool) | n/a | <pre>map(object({<br>    name                             = string<br>    friendly_name                    = optional(string)<br>    description                      = optional(string)<br>    validate_environment             = optional(bool)<br>    start_vm_on_connect              = optional(bool)<br>    custom_rdp_properties            = optional(string)<br>    personal_desktop_assignment_type = optional(string) # When the Hostpool type is 'Personal'. Possible values are Automatic and Direct.<br>    preferred_app_group_type         = optional(string) # Valid options are None, Desktop or RailApplications. Default is None.<br>    type                             = string<br>    maximum_sessions_allowed         = optional(number)<br>    load_balancer_type               = string # Possible values are BreadthFirst, DepthFirst and Persistent.<br>    expiration_date                  = string<br>    diagnostics_settings_name        = optional(string)<br>    log_categories                   = optional(list(string))<br>    retention_days                   = optional(number)<br>    scheduled_agent_updates = optional(object({<br>      enabled                   = bool<br>      timezone                  = optional(string)<br>      use_session_host_timezone = optional(string)<br><br>      schedule = optional(object({<br>        day_of_week = optional(string)<br>        hour_of_day = optional(number)<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_internal_dns_name_label"></a> [internal\_dns\_name\_label](#input\_internal\_dns\_name\_label) | The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network. | `string` | `null` | no |
| <a name="input_key_vault_certificate_secret_url"></a> [key\_vault\_certificate\_secret\_url](#input\_key\_vault\_certificate\_secret\_url) | The Secret URL of a Key Vault Certificate, which must be specified when `protocol` is set to `Https` | `string` | `null` | no |
| <a name="input_key_vault_key_name"></a> [key\_vault\_key\_name](#input\_key\_vault\_key\_name) | n/a | `string` | `null` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Specify the name of the KV that has the customer managed key stored | `string` | `null` | no |
| <a name="input_key_vault_rg_name"></a> [key\_vault\_rg\_name](#input\_key\_vault\_rg\_name) | RG name of the KV with customer managed key | `string` | `null` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | Specifies the type of on-premise license which should be used for this Virtual Machine. Possible values are None, Windows\_Client and Windows\_Server. | `string` | `"None"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"eastus"` | no |
| <a name="input_logs_destinations_ids"></a> [logs\_destinations\_ids](#input\_logs\_destinations\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_managed_identity_ids"></a> [managed\_identity\_ids](#input\_managed\_identity\_ids) | A list of User Managed Identity ID's which should be assigned to the Virtual Machine. | `list(string)` | `null` | no |
| <a name="input_managed_identity_type"></a> [managed\_identity\_type](#input\_managed\_identity\_type) | The type of Managed Identity which should be assigned to the Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned` | `string` | `null` | no |
| <a name="input_new_relic_api_key_kv_secret_name"></a> [new\_relic\_api\_key\_kv\_secret\_name](#input\_new\_relic\_api\_key\_kv\_secret\_name) | n/a | `string` | `null` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite` | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard\_LRS, StandardSSD\_LRS, Premium\_LRS, StandardSSD\_ZRS and Premium\_ZRS. | `string` | `"Premium_ZRS"` | no |
| <a name="input_ou_path"></a> [ou\_path](#input\_ou\_path) | n/a | `string` | `null` | no |
| <a name="input_patch_mode"></a> [patch\_mode](#input\_patch\_mode) | Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform` | `string` | `"Manual"` | no |
| <a name="input_platform_fault_domain_count"></a> [platform\_fault\_domain\_count](#input\_platform\_fault\_domain\_count) | Specifies the number of fault domains that are used | `number` | `3` | no |
| <a name="input_platform_update_domain_count"></a> [platform\_update\_domain\_count](#input\_platform\_update\_domain\_count) | Specifies the number of update domains that are used | `number` | `5` | no |
| <a name="input_private_ip_address_allocation_type"></a> [private\_ip\_address\_allocation\_type](#input\_private\_ip\_address\_allocation\_type) | The allocation method used for the Private IP Address. Possible values are Dynamic and Static. | `string` | `"Dynamic"` | no |
| <a name="input_proximity_group_name"></a> [proximity\_group\_name](#input\_proximity\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_script_path"></a> [script\_path](#input\_script\_path) | n/a | `string` | `"newrelic.ps1"` | no |
| <a name="input_service_account_kv_secret_name"></a> [service\_account\_kv\_secret\_name](#input\_service\_account\_kv\_secret\_name) | n/a | `string` | `null` | no |
| <a name="input_service_account_password_kv_secret_name"></a> [service\_account\_password\_kv\_secret\_name](#input\_service\_account\_password\_kv\_secret\_name) | n/a | `string` | `null` | no |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | The ID of an Image which each Virtual Machine should be based on | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | RG name where the Storage account resides | `string` | `null` | no |
| <a name="input_storage_account_rg"></a> [storage\_account\_rg](#input\_storage\_account\_rg) | RG name where the Storage account resides | `string` | `null` | no |
| <a name="input_storage_account_uri"></a> [storage\_account\_uri](#input\_storage\_account\_uri) | The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. Passing a `null` value will utilize a Managed Storage Account to store Boot Diagnostics. | `string` | `null` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet to use in VM scale set | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | The Virtual Machine SKU for the Virtual Machine, Default is Standard\_A2\_V2 | `string` | `"Standard_D8s_v3"` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the virtual network | `string` | `null` | no |
| <a name="input_virtual_network_rg"></a> [virtual\_network\_rg](#input\_virtual\_network\_rg) | RG name where the Virtual Network resides | `string` | `null` | no |
| <a name="input_vm_availability_set_name"></a> [vm\_availability\_set\_name](#input\_vm\_availability\_set\_name) | n/a | `string` | `null` | no |
| <a name="input_vm_names"></a> [vm\_names](#input\_vm\_names) | n/a | <pre>map(object({<br>    name         = string<br>    zones        = optional(string)<br>    hostpool_key = string<br>  }))</pre> | `{}` | no |
| <a name="input_vm_time_zone"></a> [vm\_time\_zone](#input\_vm\_time\_zone) | Specifies the Time Zone which should be used by the Virtual Machine | `string` | `null` | no |
| <a name="input_windows_distribution_list"></a> [windows\_distribution\_list](#input\_windows\_distribution\_list) | Pre-defined Azure Windows VM images list | <pre>map(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | <pre>{<br>  "win10-19h2-pro-g2": {<br>    "offer": "windows-10",<br>    "publisher": "MicrosoftWindowsDesktop",<br>    "sku": "19h2-pro-g2",<br>    "version": "latest"<br>  },<br>  "win10-21h2-pro": {<br>    "offer": "Windows-10",<br>    "publisher": "MicrosoftWindowsDesktop",<br>    "sku": "win10-21h2-pro",<br>    "version": "latest"<br>  },<br>  "win10-22h2-avd": {<br>    "offer": "Windows-10",<br>    "publisher": "MicrosoftWindowsDesktop",<br>    "sku": "win10-22h2-avd",<br>    "version": "latest"<br>  },<br>  "win11-22h2-avd": {<br>    "offer": "windows-11",<br>    "publisher": "MicrosoftWindowsDesktop",<br>    "sku": "win11-22h2-avd",<br>    "version": "latest"<br>  }<br>}</pre> | no |
| <a name="input_windows_distribution_name"></a> [windows\_distribution\_name](#input\_windows\_distribution\_name) | Variable to pick an OS flavour for Windows based VM. Possible values include: winserver, wincore, winsql | `string` | `"win10-21h2-pro"` | no |
| <a name="input_winrm_protocol"></a> [winrm\_protocol](#input\_winrm\_protocol) | Specifies the protocol of winrm listener. Possible values are `Http` or `Https` | `string` | `null` | no |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | n/a | <pre>map(object({<br>    name                      = string<br>    friendly_name             = optional(string)<br>    description               = optional(string)<br>    diagnostics_settings_name = optional(string)<br>    log_categories            = optional(list(string))<br>    retention_days            = optional(number)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_virtual_desktop_host_pool_id"></a> [azure\_virtual\_desktop\_host\_pool\_id](#output\_azure\_virtual\_desktop\_host\_pool\_id) | Name of the Azure Virtual Desktop host pool |
| <a name="output_azure_virtual_desktop_host_pool_name"></a> [azure\_virtual\_desktop\_host\_pool\_name](#output\_azure\_virtual\_desktop\_host\_pool\_name) | Name of the Azure Virtual Desktop host pool |
| <a name="output_azurerm_virtual_desktop_application_group_name"></a> [azurerm\_virtual\_desktop\_application\_group\_name](#output\_azurerm\_virtual\_desktop\_application\_group\_name) | Name of the Azure Virtual Desktop DAG |
| <a name="output_azurerm_virtual_desktop_workspace_id"></a> [azurerm\_virtual\_desktop\_workspace\_id](#output\_azurerm\_virtual\_desktop\_workspace\_id) | n/a |
| <a name="output_azurerm_virtual_desktop_workspace_name"></a> [azurerm\_virtual\_desktop\_workspace\_name](#output\_azurerm\_virtual\_desktop\_workspace\_name) | Name of the Azure Virtual Desktop workspace |
<!-- END_TF_DOCS -->