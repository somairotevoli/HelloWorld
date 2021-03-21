// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "HelloWorld",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_14),
    ],

    targets: [
        .target(
           name: "SwiftUIWindowBinder",
           path: "SwiftUIWindowBinder"), //path for target to look for sources
        
    ]
)
