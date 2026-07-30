#!/usr/bin/env bash
# What block height was this tx mined?
# 49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb

set -euo pipefail

bitcoin-cli() {
  command bitcoin-cli ${BITCOIN_CONF:+-conf="$BITCOIN_CONF"} "$@"
}

block_hash=$(bitcoin-cli -signet getrawtransaction \
  49990a9c8e60c8cba979ece134124695ffb270a98ba39c9824e42c4dc227c7eb true |
  jq -r '.blockhash')
bitcoin-cli -signet getblockheader "$block_hash" | jq -r '.height'
