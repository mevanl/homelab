#!/usr/bin/env bash
# Wrapper for docker compose that sources global.env first so its
# variables are available for ${...} substitution in compose files,
# not just inside containers via env_file.
#
# Usage: same as docker compose, e.g.
#   dc up -d
#   dc down
#   dc logs -f

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_ENV="$SCRIPT_DIR/../global.env"

if [[ -f "$GLOBAL_ENV" ]]; then
  set -a
  source "$GLOBAL_ENV"
  set +a
else
  echo "Warning: $GLOBAL_ENV not found, continuing without it" >&2
fi

exec docker compose "$@"