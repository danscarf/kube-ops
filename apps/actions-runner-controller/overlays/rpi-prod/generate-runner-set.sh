#!/bin/bash

# Set default values
NAMESPACE="arc-runners"
GITHUB_CONFIG_SECRET="pre-defined-secret"
GITHUB_CONFIG_URL="https://github.com/spectio"
CONTROLLER_SA_NAME="arc-controller"
CONTROLLER_SA_NAMESPACE="arc-systems"
OUTPUT_FILE="arc-runner-set.yaml"

# Generate the helm template
helm template arc-runner-set \
    --namespace="${NAMESPACE}" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set \
    --set githubConfigSecret="${GITHUB_CONFIG_SECRET}" \
    --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
    --set controllerServiceAccount.name="${CONTROLLER_SA_NAME}" \
    --set controllerServiceAccount.namespace="${CONTROLLER_SA_NAMESPACE}" > "${OUTPUT_FILE}"

echo "Runner set template generated in ${OUTPUT_FILE}"
