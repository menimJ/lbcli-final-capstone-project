#!/usr/bin/env bash
# What is the hash of block 243,833?

set -euo pipefail

bitcoin-cli() {
  command bitcoin-cli ${BITCOIN_CONF:+-conf="$BITCOIN_CONF"} "$@"
}

bitcoin-cli -signet getblockhash 243833
