#!/bin/bash

# Generates the OpenClaw operator manifests from the Helm chart
# into the third-party/ directory for Kustomize to consume.
#
# Usage: ./generate-manifests.sh
#
# After running, review the generated manifests and commit them.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${SCRIPT_DIR}/third-party"
NAMESPACE="openclaw-operator-system"
CHART="oci://ghcr.io/openclaw-rocks/charts/openclaw-operator"

# Clean and recreate output directory
rm -rf "${OUTPUT_DIR}"
mkdir -p "${OUTPUT_DIR}"

# Template the Helm chart into a single file
helm template openclaw-operator \
    "${CHART}" \
    --namespace="${NAMESPACE}" \
    --include-crds \
    > "${OUTPUT_DIR}/all.yaml"

echo "Operator manifests generated in ${OUTPUT_DIR}/all.yaml"
echo "Review the output, then optionally split into individual files."
