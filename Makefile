SHELL := /bin/bash

SETUP_SCRIPT := ./scripts/setup.sh
CHECK_SCRIPT := ./scripts/check_fvm.sh

.PHONY: setup check-fvm format analyze test

setup:
	@"$(SETUP_SCRIPT)"

check-fvm:
	@"$(CHECK_SCRIPT)"

format:
	@fvm flutter format lib test

analyze:
	@fvm flutter analyze

test:
	@fvm flutter test
