#!/usr/bin/env bash

set -euo pipefail

configure_terraform_ci() {
  export TF_IN_AUTOMATION=true
  export TF_INPUT=0
  export CHECKPOINT_DISABLE=true
  export GIT_TERMINAL_PROMPT=0
}

configure_azure_devops_git_auth() {
  if [[ -n "${SYSTEM_ACCESSTOKEN:-}" ]]; then
    echo "Configuring Azure DevOps Git auth with System.AccessToken"
    git config --global http.https://dev.azure.com/.extraheader "AUTHORIZATION: bearer ${SYSTEM_ACCESSTOKEN}"
  else
    echo "No Azure DevOps Git credential was provided"
  fi
}

verify_template_module_access() {
  echo "Checking access to Azure DevOps template module repo"
  if ! git ls-remote https://dev.azure.com/CCOE-Azure/IaC/_git/template HEAD >/dev/null; then
    echo "Unable to read https://dev.azure.com/CCOE-Azure/IaC/_git/template." >&2
    echo "Grant the pipeline Build Service identity read access to the template repo and make sure scripts can access System.AccessToken." >&2
    exit 1
  fi
}

create_temp_tf_data_dir() {
  export TF_DATA_DIR
  TF_DATA_DIR="$(mktemp -d)"

  cleanup_tf_data_dir() {
    rm -rf "${TF_DATA_DIR}"
  }

  trap cleanup_tf_data_dir EXIT
}

configure_arm_auth() {
  export ARM_CLIENT_ID="${servicePrincipalId:?servicePrincipalId is required}"
  export ARM_TENANT_ID="${tenantId:?tenantId is required}"
  export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"

  if [[ -n "${servicePrincipalKey:-}" ]]; then
    export ARM_CLIENT_SECRET="${servicePrincipalKey}"
  fi

  if [[ -n "${idToken:-}" ]]; then
    export ARM_USE_OIDC=true
    export ARM_OIDC_TOKEN="${idToken}"
  fi

  if [[ -n "${AZURESUBSCRIPTION_SERVICE_CONNECTION_ID:-}" ]]; then
    export ARM_OIDC_AZURE_SERVICE_CONNECTION_ID="${AZURESUBSCRIPTION_SERVICE_CONNECTION_ID}"
  fi
}

configure_terraform_ci
configure_azure_devops_git_auth
