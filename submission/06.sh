#!/usr/bin/env bash
# Only one tx in block 243,821 signals opt-in RBF. What is its txid?

set -euo pipefail

bitcoin-cli() {
  command bitcoin-cli ${BITCOIN_CONF:+-conf="$BITCOIN_CONF"} "$@"
}

block_hash=$(bitcoin-cli -signet getblockhash 243821)
bitcoin-cli -signet getblock "$block_hash" 2 |
  jq -r '.tx[] | select(any(.vin[]?; .sequence < 4294967294)) | .txid'
