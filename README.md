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

The current pipeline surface is Terraform-only. App packaging/deployment stages from
the `enterprise-ai-chatbot` baseline are intentionally not enabled because this repo
does not contain the chatbot app package assets.

## Pipeline Configuration

### GitHub Actions

`.github/workflows/terraform.yml` is aligned with the `enterprise-ai-chatbot`
Terraform workflow. It validates and plans `dev` and/or `sandbox` based on
repository variables, can apply those environments when enabled, creates release
tags after dev apply, and can publish snapshots to GitHub stage and Azure DevOps
repos.

Required GitHub repository variables:

- `DEPLOY_DEV`
- `DEPLOY_SANDBOX`
- `ENABLE_GITHUB_APPLY`
- `GH_TF_TEMPLATE_REPO`
- `STAGE_REPOSITORY`
- `ADO_DEV_REPOSITORY`
- `PUBLISH_ADO_SANDBOX`
- `ADO_SANDBOX_REPOSITORY`

Required GitHub repository secrets:

- `AZURE_ADO_PAT2`
- `STAGE_REPO_TOKEN`
- `ADO_DEV_REPO_PAT`
- `ADO_SANDBOX_REPO_PAT`

Optional GitHub repository secret:

- `INFRACOST_API_KEY`

The disabled `Apply Dev with OIDC` job also checks for
`AZURE_OIDC_CLIENT_ID` as a repository variable or secret, with `ARM_CLIENT_ID`
as a fallback. Each GitHub environment used by Terraform must provide
`ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_TENANT_ID`, and
`ARM_SUBSCRIPTION_ID`.

### Azure DevOps

`azure-pipelines.yml` is aligned with the sibling repo's variable-driven
Terraform flow. It runs `Validate`, `Plan`, and gated `Apply` stages for the
environment named by `ENVIRONMENT`. The pipeline uses root-level
`scripts/azure-pipelines/*` helpers and `templates/shared-runner-hygiene.yml`.

Required Azure DevOps variable groups:

- `azure-terraform`
- `iac-shared-vars`

Required Azure DevOps variables:

- `ADO_AGENT_POOL`
- `ADO_AGENT_VM_IMAGE`
- `ENVIRONMENT`
- `AZURE_SERVICE_CONNECTION`
- `ENABLE_ADO_TERRAFORM_APPLY`

`ENABLE_ADO_TERRAFORM_APPLY` must be set to `true`, `True`, or `TRUE` for the
ADO apply stage to run. The current shared variable group contains the older
`ENABLE_ADO_APPLY` name; add `ENABLE_ADO_TERRAFORM_APPLY` or keep apply disabled.

## Validation

```bash
cd terraform
terraform init -backend=false -reconfigure -input=false
terraform fmt -check -recursive
terraform validate
```
