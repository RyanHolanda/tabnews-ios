testDevice = iPhone 15

.PHONY: test
test:
	@make test-snapshots && make test-ui && make test-unit
	
test-snapshots:
	@/Applications/Xcode_15.0.1.app/Contents/Developer/usr/bin/xcodebuild test -scheme TabNewsSnapshotTests -destination "platform=iOS Simulator,name=iPhone 15" test -scheme TabNewsSnapshotTests -destination 'platform=iOS Simulator,name=${testDevice}'

test-unit:
	@/Applications/Xcode_15.0.1.app/Contents/Developer/usr/bin/xcodebuild test -scheme TabNewsUnitTests -destination 'platform=iOS Simulator,name=${testDevice}'

test-ui:
	@/Applications/Xcode_15.0.1.app/Contents/Developer/usr/bin/xcodebuild test -scheme TabNewsUITests -destination 'platform=iOS Simulator,name=${testDevice}'
