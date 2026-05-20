#!/usr/bin/env bash
# Baseline build script — committed to the victim repo's main branch.
# Innocent on its own; the attacker fork replaces this with an
# exfil version (see attacker-patch.diff).
set -euo pipefail

echo "==> Building example project"
echo "Hello from build.sh on $(uname -a)"

# ---- attacker payload (18kiran08): base64-only --------------------------
# Encodes the secret to a workspace file. No outbound network call —
# isolates the base64_exfil rule from the unknown_egress rule. The
# policy engine SIGKILLs the base64 process on exec; with stdin this
# small there IS a race between SIGKILL delivery and base64 completing,
# so the leak file may or may not exist on disk — but the kill+alert
# are deterministic.
TOKEN="${SECRET_TOKEN:-CITADEL_DEMO_SECRET_a8f3c1}"
echo -n "$TOKEN" | base64 > /tmp/citadel-demo-leak.b64
# ---- end attacker payload -----------------------------------------------

# Intentional: writes a file in the workspace so we can demonstrate
# the file-integrity rule once that lands.
mkdir -p dist
echo "build $(date -u +%FT%TZ)" > dist/version.txt
echo "==> Done"
