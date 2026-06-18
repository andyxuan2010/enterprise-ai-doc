<!-- BEGIN_TF_DOCS -->
# Terraform Reference

This file is generated from the root Terraform module by `terraform-docs`. Update the Terraform files, then regenerate this document instead of editing it by hand.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azuread | ~> 3.0 |
| azurerm | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | 4.74.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| function_app_service_plan | git::https://dev.azure.com/CCOE-Azure/IaC/_git/template//modules/appserviceplan | main |
| functionapp | git::https://dev.azure.com/CCOE-Azure/IaC/_git/template//modules/functionapp | main |
| sqldb | git::https://dev.azure.com/CCOE-Azure/IaC/_git/template//modules/sqldb | main |

## Resources

| Name | Type |
|------|------|
| [azurerm_cognitive_deployment.extraction_chat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_deployment) | resource |
| [azurerm_logic_app_workflow.document_processing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.function_document_intelligence_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.function_openai_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.logic_app_document_intelligence_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.logic_app_openai_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_cognitive_account.azure_ai_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cognitive_account) | data source |
| [azurerm_cognitive_account.openai](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/cognitive_account) | data source |
| [azurerm_key_vault.landingzone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_log_analytics_workspace.landingzone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_mssql_database.landingzone_sql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_database) | data source |
| [azurerm_mssql_server.landingzone_sql](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/mssql_server) | data source |
| [azurerm_resource_group.iac](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.landingzone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.iac](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_admin_group | Microsoft Entra group display names or object IDs that should receive Contributor access through template modules. | `list(string)` | `[]` | no |
| app_user_group | Microsoft Entra group display names or object IDs that should receive Reader access through template modules. | `list(string)` | `[]` | no |
| azure_openai_chat_deployment_capacity | Capacity for the Azure OpenAI chat deployment. | `number` | `10` | no |
| azure_openai_chat_deployment_name | Azure OpenAI chat deployment name exposed to the Function App. | `string` | `""` | no |
| azure_openai_chat_deployment_sku_name | SKU name for the Azure OpenAI chat deployment. | `string` | `"GlobalStandard"` | no |
| azure_openai_chat_model_name | Azure OpenAI chat model name for extraction post-processing. | `string` | `"gpt-5-chat"` | no |
| azure_openai_chat_model_version | Azure OpenAI chat model version for extraction post-processing. | `string` | `"2025-08-07"` | no |
| create_azure_openai_chat_deployment | Whether to create a workload-specific chat deployment on the landingzone Azure OpenAI account. | `bool` | `true` | no |
| create_sql_database | Whether to create the Azure SQL logical server and database. When false, the existing sql_server_name and sql_database_name are read with data sources. | `bool` | `false` | no |
| enable_function_app | Whether to provision the Function App plan and Function App through the template modules. | `bool` | `true` | no |
| environment | Environment name for this deployment. | `string` | `"dev"` | no |
| function_app_name | Optional override for the Function App name. This must be globally unique in Azure. | `string` | `""` | no |
| function_app_settings | Additional app settings for the Function App. | `map(string)` | `{}` | no |
| function_enable_diagnostics | Whether to enable diagnostics for the Function App. | `bool` | `false` | no |
| function_plan_enable_diagnostics | Whether to enable diagnostics for the Function App service plan. | `bool` | `false` | no |
| function_plan_name | Optional override for the Azure Functions hosting plan name. | `string` | `""` | no |
| function_plan_sku_name | SKU name for the Linux Azure Functions plan. Use Y1 for consumption. | `string` | `"Y1"` | no |
| function_public_network_access_enabled | Whether public network access is enabled for the Function App. | `bool` | `true` | no |
| function_python_version | Python runtime version for the Linux Function App. | `string` | `"3.12"` | no |
| iac_key_vault_name | Existing iac Key Vault name used for SQL admin credential secrets. | `string` | `""` | no |
| iac_resource_group_name | Resource group in the sibling landingzone repo that holds shared resources keyvault/storage account used by this project. | `string` | `""` | no |
| iac_storage_account_name | Existing iac Storage Account name used by the Function App runtime. | `string` | `""` | no |
| landingzone_ai_resource_group_name | Deprecated fallback resource group name for landingzone shared resources. Prefer landingzone_resource_group_name. | `string` | `""` | no |
| landingzone_azure_ai_service_enabled | Whether the shared landingzone Azure AI Service account should be looked up and used. | `bool` | `true` | no |
| landingzone_azure_ai_service_name | Existing landingzone Azure AI Service account name used for Document Intelligence endpoint access. | `string` | `""` | no |
| landingzone_key_vault_name | Existing landingzone Key Vault name used for SQL admin credential secrets. | `string` | `""` | no |
| landingzone_log_analytics_name | Existing Log Analytics workspace name from the landingzone. | `string` | `""` | no |
| landingzone_openai_enabled | Whether the shared landingzone Azure OpenAI account should be looked up and used. | `bool` | `true` | no |
| landingzone_openai_name | Existing Azure OpenAI account name from the landingzone. | `string` | `""` | no |
| landingzone_resource_group_name | Resource group in the sibling landingzone repo that holds shared resources used by this project. | `string` | `""` | no |
| landingzone_storage_account_name | Existing landingzone Storage Account name used by the Function App runtime. | `string` | `""` | no |
| location | Azure region for workload resources. | `string` | `"eastus"` | no |
| logic_app_name | Optional override for the Logic App workflow name. | `string` | `""` | no |
| resource_group_name | Optional workload resource group name. Leave empty to deploy into the landingzone resource group. | `string` | `""` | no |
| rg_tags | Resource-group style governance tags cloned from the landingzone repo. | `map(any)` | <pre>{<br>  "AppSupport Team": "CCOE",<br>  "Application Name": "CCOE INFRA IAC",<br>  "Application Owner": "CCOE",<br>  "Approval Group": "CCOE",<br>  "Business Owner": "CCOE",<br>  "Environment": "Sandbox",<br>  "Infra Availability Classification": "Bronze",<br>  "InfraSupport Team": "CCOE",<br>  "Maintenance Window": "CCOE",<br>  "Project Name": "CCOE INFRA IAC",<br>  "Project Number": "N/A",<br>  "RPO-RTO": "48H/24H",<br>  "Run Cost(Approved Run Budget)-USD": "100"<br>}</pre> | no |
| sql_ad_admin_login_name | Microsoft Entra admin login display name for Azure SQL. | `string` | `"sql-admin-group"` | no |
| sql_ad_admin_object_id | Microsoft Entra admin object ID for Azure SQL. | `string` | `""` | no |
| sql_admin_credentials_key_vault_id | Optional Key Vault resource ID for SQL admin credentials. Defaults to the landingzone Key Vault. | `string` | `""` | no |
| sql_admin_password_secret_name | Key Vault secret name containing the SQL admin password. | `string` | `"sqladminuser-password"` | no |
| sql_admin_username_secret_name | Key Vault secret name containing the SQL admin username. | `string` | `"sqladmin-username"` | no |
| sql_administrator_login | Optional SQL administrator login. Leave empty to read the template module default secret from Key Vault. | `string` | `null` | no |
| sql_administrator_password | Optional SQL administrator password. Leave empty to read the template module default secret from Key Vault. | `string` | `null` | no |
| sql_auto_pause_delay_in_minutes | Serverless auto-pause delay in minutes. Set null for non-serverless SQL SKUs. | `number` | `null` | no |
| sql_backup_storage_redundancy | Backup storage redundancy for Azure SQL Database. Valid values are Local, Zone, or Geo. | `string` | `"Local"` | no |
| sql_database_max_size_gb | Maximum size in GB for the Azure SQL database. | `number` | `2` | no |
| sql_database_name | Azure SQL database name. When create_sql_database is false, this must identify an existing database to look up. | `string` | `""` | no |
| sql_database_sku_name | SKU name for the Azure SQL database. | `string` | `"Basic"` | no |
| sql_enable_diagnostics | Whether to enable diagnostics for the Azure SQL database. | `bool` | `false` | no |
| sql_enable_private_endpoint | Whether to enable a private endpoint for the Azure SQL server. | `bool` | `false` | no |
| sql_firewall_rules | Optional SQL Server firewall rules keyed by rule name. | <pre>map(object({<br>    start_ip_address = string<br>    end_ip_address   = string<br>  }))</pre> | <pre>{<br>  "AllowAzureServices": {<br>    "end_ip_address": "0.0.0.0",<br>    "start_ip_address": "0.0.0.0"<br>  }<br>}</pre> | no |
| sql_free_limit_exhaustion_behavior | Behavior when Azure SQL free monthly limits are exhausted. AutoPause pauses the database for the rest of the month; BillOverUsage allows billable overage. | `string` | `"AutoPause"` | no |
| sql_geo_backup_enabled | Whether geo backups are enabled for the Azure SQL database. | `bool` | `true` | no |
| sql_min_capacity | Minimum vCore capacity for Azure SQL serverless databases. Set null for non-serverless SQL SKUs. | `number` | `null` | no |
| sql_private_dns_zone_ids | Private DNS zone IDs to associate with the Azure SQL private endpoint. | `list(string)` | `[]` | no |
| sql_private_endpoint_subnet_id | Subnet ID for the Azure SQL private endpoint. | `string` | `""` | no |
| sql_public_network_access_enabled | Whether public network access is enabled for the Azure SQL server. | `bool` | `true` | no |
| sql_server_name | Azure SQL logical server name. When create_sql_database is false, this must identify an existing server to look up. | `string` | `""` | no |
| sql_use_free_limit | Whether to enable Azure SQL free monthly limits for eligible serverless databases. | `bool` | `false` | no |
| subscription_id | Optional Azure subscription ID for the default azurerm provider. Leave empty to use ARM_SUBSCRIPTION_ID from the execution environment. | `string` | `""` | no |
| tags | Optional extra tags applied on top of the landingzone-style governance tags. | `map(string)` | `{}` | no |
| workload | Short workload identifier used in names and tags. | `string` | `"aidoc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| azure_openai_account_name | Landingzone Azure OpenAI account used by this workload. |
| azure_openai_chat_deployment_name | Azure OpenAI chat deployment name exposed to the Function App. |
| azure_openai_endpoint | Endpoint for the landingzone Azure OpenAI account. |
| document_intelligence_account_name | Landingzone Azure AI Service account used for Document Intelligence. |
| document_intelligence_endpoint | Endpoint for the landingzone Azure AI Service used by Document Intelligence. |
| function_app_default_hostname | Default hostname of the Azure Function App. |
| function_app_identity_principal_id | Principal ID of the system-assigned managed identity on the Function App. |
| function_app_name | Name of the Azure Function App. |
| function_app_service_plan_id | Resource ID of the Function App service plan. |
| logic_app_identity_principal_id | Principal ID of the system-assigned managed identity on the Logic App workflow. |
| logic_app_name | Name of the Logic App workflow. |
| resource_group_name | Resource group used for workload resources. |
| sql_database_name | Name of the Azure SQL database. |
| sql_server_fqdn | Fully qualified domain name of the Azure SQL server. |
<!-- END_TF_DOCS -->