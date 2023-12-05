.PHONY: test
test:
	@make test-snapshots && make test-ui && make test-unit
test-snapshots:
	@xcodebuild test -scheme TabNewsSnapshotTests -destination 'platform=iOS Simulator,name=iPhone 15'

test-unit:
	@xcodebuild test -scheme TabNewsUnitTests -destination 'platform=iOS Simulator,name=iPhone 15'

test-ui:
	@xcodebuild test -scheme TabNewsUITests -destination 'platform=iOS Simulator,name=iPhone 15'
	