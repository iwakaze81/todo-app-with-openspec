SHELL := /bin/bash

SETUP_SCRIPT := ./scripts/setup.sh
CHECK_SCRIPT := ./scripts/check_fvm.sh

.PHONY: setup check-fvm format analyze test pub-get build-runner build-runner-watch

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

pub-get:
	@fvm flutter pub get

build-runner:
	@fvm flutter pub run build_runner build --delete-conflicting-outputs

build-runner-watch:
	@fvm flutter pub run build_runner watch --delete-conflicting-outputs
