#!/usr/bin/env bash
# Which tx in block 216,351 spends the coinbase output of block 216,128?

set -euo pipefail

bitcoin-cli() {
  command bitcoin-cli ${BITCOIN_CONF:+-conf="$BITCOIN_CONF"} "$@"
}

coinbase_block=$(bitcoin-cli -signet getblockhash 216128)
coinbase_txid=$(bitcoin-cli -signet getblock "$coinbase_block" | jq -r '.tx[0]')
spending_block=$(bitcoin-cli -signet getblockhash 216351)

bitcoin-cli -signet getblock "$spending_block" 2 |
  jq -r --arg txid "$coinbase_txid" '.tx[] | select(any(.vin[]?; .txid? == $txid)) | .txid'
