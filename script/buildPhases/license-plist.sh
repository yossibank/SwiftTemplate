export $(grep -v '^#' ../.env | xargs)

cd ../BuildTools

xcrun --sdk macosx swift build -c release \
    --package-path .build/checkouts/LicensePlist \
    --product license-plist

.build/checkouts/LicensePlist/.build/release/license-plist \
    --package-path Package.resolved \
    --package-path ../SwiftTemplate.xcworkspace/xcshareddata/swiftpm/Package.resolved \
    --package-path ../Macro/BuilderMacro/Package.resolved \
    --output-path ../App/iOS/Settings.bundle \
    --github-token $GITHUB_ACCESS_TOKEN
