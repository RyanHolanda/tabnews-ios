testDevice = iPhone 15

.PHONY: test
test:
	@make test-snapshots && make test-ui && make test-unit
	
test-snapshots:
	@set -o pipefail && xcodebuild -clonedSourcePackagesDirPath SourcePackages -skipPackagePluginValidation test -scheme TabNewsSnapshotTests -destination 'platform=iOS Simulator,name=${testDevice}' | xcpretty

test-unit:
	@set -o pipefail && xcodebuild \
	 -clonedSourcePackagesDirPath SourcePackages \
	 -skipPackagePluginValidation \
	  test -scheme TabNewsUnitTests \
	   -destination 'platform=iOS Simulator,name=${testDevice}' | xcpretty
#	 -resolvePackageDependencies \
#	 -disableAutomaticPackageResolution \

test-ui:
	@set -o pipefail && xcodebuild -clonedSourcePackagesDirPath SourcePackages \
	 -skipPackagePluginValidation \
	  test -scheme TabNewsUITests \
	   -destination 'platform=iOS Simulator,name=${testDevice}' | xcpretty
