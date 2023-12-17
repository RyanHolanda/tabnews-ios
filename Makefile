testDevice = iPhone 15

.PHONY: test
test:
	@make test-snapshots && make test-ui && make test-unit
	
test-snapshots:
	@xcodebuild test -scheme TabNewsSnapshotTests -destination 'platform=iOS Simulator,name=${testDevice}'

test-unit:
	@xcodebuild -skipPackagePluginValidation test -scheme TabNewsUnitTests -destination 'platform=iOS Simulator,name=${testDevice}'

test-ui:
	@xcodebuild test -scheme TabNewsUITests -destination 'platform=iOS Simulator,name=${testDevice}'
