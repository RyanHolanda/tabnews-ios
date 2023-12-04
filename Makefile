.PHONY: test
test:
	@xcodebuild test -scheme TabNewsUITests -destination 'platform=iOS Simulator,name=iPhone 15' && xcodebuild test -scheme TabNewsSnapshotTests -destination 'platform=iOS Simulator,name=iPhone 15' && xcodebuild test -scheme TabNewsUnitTests -destination 'platform=iOS Simulator,name=iPhone 15'

.PHONY: test-snapshots
test-snapshots:
	@xcodebuild test -scheme TabNewsSnapshotTests -destination 'platform=iOS Simulator,name=iPhone 15'
	
.PHONY: test-unit
test-unit:
	@xcodebuild test -scheme TabNewsUnitTests -destination 'platform=iOS Simulator,name=iPhone 15'
	
.PHONY: test-ui
test-ui:
	@xcodebuild test -scheme TabNewsUITests -destination 'platform=iOS Simulator,name=iPhone 15'

