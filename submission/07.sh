#!/usr/bin/env bash
# what is the coinbase tx in this block 243,834

set -euo pipefail

bitcoin-cli() {
  command bitcoin-cli ${BITCOIN_CONF:+-conf="$BITCOIN_CONF"} "$@"
}

block_hash=$(bitcoin-cli -signet getblockhash 243834)
bitcoin-cli -signet getblock "$block_hash" | jq -r '.tx[0]'
