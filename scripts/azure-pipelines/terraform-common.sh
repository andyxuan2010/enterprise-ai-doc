#!/usr/bin/env bash

set -euo pipefail

configure_terraform_ci() {
  export TF_IN_AUTOMATION=true
  export TF_INPUT=0
  export CHECKPOINT_DISABLE=true
  export GIT_TERMINAL_PROMPT=0
}

configure_azure_devops_git_auth() {
  if [[ -n "${AZURE_ADO_PAT2:-}" && "${AZURE_ADO_PAT2}" != '$('* ]]; then
    git config --global --unset-all http.https://dev.azure.com/.extraheader || true
    git config --global --unset-all url."https://ado:${AZURE_ADO_PAT2}@dev.azure.com/".insteadOf || true
    basic_auth="$(printf ':%s' "${AZURE_ADO_PAT2}" | base64 | tr -d '\n')"
    git config --global http.https://dev.azure.com/.extraheader "AUTHORIZATION: basic ${basic_auth}"
  elif [[ -n "${SYSTEM_ACCESSTOKEN:-}" ]]; then
    git config --global http.https://dev.azure.com/.extraheader "AUTHORIZATION: bearer ${SYSTEM_ACCESSTOKEN}"
  fi
}

verify_template_module_access() {
  echo "Checking access to Azure DevOps template module repo"
  if ! git ls-remote https://dev.azure.com/CCOE-Azure/IaC/_git/template HEAD >/dev/null; then
    echo "Unable to read https://dev.azure.com/CCOE-Azure/IaC/_git/template." >&2
    echo "Grant the pipeline identity read access to the template repo or define a secret pipeline variable named AZURE_ADO_PAT2 with Code Read access." >&2
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
