#!/usr/bin/env bash
# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb

set -euo pipefail

bitcoin-cli() {
  command bitcoin-cli ${BITCOIN_CONF:+-conf="$BITCOIN_CONF"} "$@"
}

txid=b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb
tx=$(bitcoin-cli -signet getrawtransaction "$txid" true)
input_sats=0

while IFS=$'\t' read -r previous_txid previous_vout; do
  previous_tx=$(bitcoin-cli -signet getrawtransaction "$previous_txid" true)
  value=$(jq -r --argjson vout "$previous_vout" '.vout[$vout].value' <<<"$previous_tx")
  input_sats=$((input_sats + $(jq -n --argjson value "$value" '($value * 100000000) | round')))
done < <(jq -r '.vin[] | select(.txid != null) | [.txid, .vout] | @tsv' <<<"$tx")

output_sats=$(jq '([.vout[].value] | add) * 100000000 | round' <<<"$tx")
echo $((input_sats - output_sats))
