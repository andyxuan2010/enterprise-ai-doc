#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${script_dir}/terraform-common.sh"
create_temp_tf_data_dir

echo "Running terraform version"
terraform version

echo "Running terraform fmt -check -recursive"
terraform fmt -check -recursive

echo "Running terraform init without backend"
terraform init -backend=false -reconfigure -input=false -no-color

echo "Running terraform validate"
timeout 10m terraform validate -no-color
