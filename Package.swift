// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "HelloWorld",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
    ],

    targets: [
        .target(
           name: "SwiftUIWindowBinder",
           path: "Sources"), //path for target to look for sources
        
    ]
)
