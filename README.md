# TabNews iOS
This app is a TabNews client for iOS. You can see the original TabNews [here](https://github.com/filipedeschamps/tabnews.com.br).
\
**It's still in early development, but I have plans to launch it on App Store once I finish the 1.0 version**

## Tools
**XCode 15.1**\
**SwiftUI**\
**Fastlane**

## Install and Run
To run this app on your machine is very easy. Just clone this repository, Build and Run the "TabNews" Target

## Run Tests
To run tests from the CLI we use Fastlane(Be sure to have it installed). Now, Navigate to the project root and use the following command:

• `bundle exec fastlane test` (This command will run all test targets)

**To run tests from Xcode:**\
Select the TabNews target in the debug version, and then, Product > Test

## Updating Snapshot Tests
To update snapshot tests, just to to `Snapshooter.swift` and change the variable updateSnapshots to true. After updating, just set it as false again


