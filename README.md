# Enterprise AI Document Extraction

Terraform infrastructure for extracting structured data from invoices, claims, contracts, PDFs, resumes, and forms.

## Azure Services

- Landingzone Azure AI Service for Document Intelligence document parsing and extraction.
- Landingzone Azure OpenAI Service with workload-owned deployments for post-processing, normalization, and summarization.
- Azure Functions, provisioned through the shared template `functionapp` module, for event-driven extraction code.
- Azure Logic Apps for workflow orchestration.
- Azure SQL Database for structured extraction results. By default this repo reuses an existing SQL DB through data sources; it can also create SQL when explicitly requested.

## Project Shape

This repo was cleaned from the `enterprise-ai-chatbot` baseline. Chatbot/RAG resources such as App Service deployment packaging, Azure AI Search wiring, embedding deployments, and document-search storage containers have been removed.

The workload does not create new Cognitive Services accounts. It looks up the landingzone Azure AI Service and Azure OpenAI accounts with data sources, then creates the required Azure OpenAI deployment on the landingzone OpenAI account.

Azure SQL creation is disabled by default. With `create_sql_database = false`, Terraform looks up the existing SQL server and database named by `sql_server_name` and `sql_database_name`. Set `create_sql_database = true` to create SQL from this repo; in that mode, the SQL SKU, firewall, admin credential, private endpoint, and diagnostics variables are effective.

For sandbox SQL creation, use the Azure SQL free-offer profile: `sql_database_sku_name = "GP_S_Gen5_2"`, `sql_use_free_limit = true`, `sql_free_limit_exhaustion_behavior = "AutoPause"`, `sql_auto_pause_delay_in_minutes = 60`, `sql_min_capacity = 0.5`, `sql_database_max_size_gb = 32`, and `sql_geo_backup_enabled = false`.

## Environment Defaults

- `dev` and `sandbox` set `create_sql_database = false` and look up the SQL resources provisioned by the landingzone.
- Environments that set `create_sql_database = true` create SQL through the shared `sqldb` module, using the SQL settings in the environment tfvars file.

The current pipeline surface is Terraform-only:

- Azure DevOps: validate, plan, and apply for sandbox/dev.
- GitHub Actions: validate, plan, and optional dev apply.

## Validation

```bash
terraform init -backend=false -reconfigure -input=false
terraform fmt -check -recursive
terraform validate
```
