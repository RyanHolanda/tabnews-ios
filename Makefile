testDevice = iPhone 15

.PHONY: test
test:
	@make test-snapshots && make test-ui && make test-unit
	
test-snapshots:
	@xcodebuild -skipPackagePluginValidation test -scheme TabNewsSnapshotTests -destination 'platform=iOS Simulator,name=${testDevice}' | xcpretty

test-unit:
	@xcodebuild -skipPackagePluginValidation test -scheme TabNewsUnitTests -destination 'platform=iOS Simulator,name=${testDevice}' | xcpretty

test-ui:
	@xcodebuild -skipPackagePluginValidation test -scheme TabNewsUITests -destination 'platform=iOS Simulator,name=${testDevice}' | xcpretty
