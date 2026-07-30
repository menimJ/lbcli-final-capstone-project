#!/usr/bin/env bash
# How many new outputs were created by block 243,825?

set -euo pipefail

bitcoin-cli() {
  command bitcoin-cli ${BITCOIN_CONF:+-conf="$BITCOIN_CONF"} "$@"
}

block_hash=$(bitcoin-cli -signet getblockhash 243825)
bitcoin-cli -signet getblock "$block_hash" 2 | jq '[.tx[].vout[]] | length'
