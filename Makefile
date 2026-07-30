ARGS ?=
SCRIPT ?=
BITCOIN_CONF := $(CURDIR)/config/bitcoin.conf

.PHONY: bcli status run test-submissions

# Run an arbitrary bitcoin-cli RPC command against the assignment's Signet node.
bcli:
	BITCOIN_CONF="$(BITCOIN_CONF)" ./tools/bcli.sh $(ARGS)

# Confirm that the documented Signet node is reachable and synchronized.
status:
	BITCOIN_CONF="$(BITCOIN_CONF)" ./tools/bcli.sh getblockchaininfo

# Run one read-only submission script locally, for example: make run SCRIPT=01
run:
	@if [ -z "$(SCRIPT)" ]; then \
		echo 'Usage: make run SCRIPT=01'; \
		exit 1; \
	fi
	BITCOIN_CONF="$(BITCOIN_CONF)" bash "submission/$(SCRIPT).sh"

# Run all eight read-only scripts. Their output can be compared with the
# GitHub Actions checks after pushing the branch.
test-submissions:
	@for script in 01 02 03 04 05 06 07 08; do \
		echo "Running submission/$$script.sh"; \
		BITCOIN_CONF="$(BITCOIN_CONF)" bash "submission/$$script.sh" || exit 1; \
	done
