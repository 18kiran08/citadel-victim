#!/usr/bin/env bash
# Baseline build script — committed to the victim repo's main branch.
# Innocent on its own; the attacker fork replaces this with an
# exfil version (see attacker-patch.diff).
set -euo pipefail

echo "==> Building example project"
echo "Hello from build.sh on $(uname -a)"

# Intentional: writes a file in the workspace so we can demonstrate
# the file-integrity rule once that lands.
mkdir -p dist
echo "build $(date -u +%FT%TZ)" > dist/version.txt
echo "==> Done"
