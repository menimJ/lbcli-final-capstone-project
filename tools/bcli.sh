#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
BITCOIN_CONF=${BITCOIN_CONF:-"$REPO_ROOT/config/bitcoin.conf"}

exec bitcoin-cli -conf="$BITCOIN_CONF" -signet "$@"
