// swift-tools-version:5.3


import PackageDescription

let package = Package(
<<<<<<< HEAD
    name: "SwiftUIWindowBinder",
    
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
    ],
    
    products: [
        .library(
            name: "SwiftUIWindowBinder",
            path: "SwiftUIWindowBinder"),
    ],
    
    dependencies: [ ],
    

    
    targets: [
        .target(
            name: "SwiftUIWindowBinder",
            dependencies: [])
        ]

    name: "ios-app-helloworld-swiftui",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_14),
    ],

    targets: [
        .target(
           name: "ios-app-helloworld-swiftui",
           path: "ios-app-helloworld-swiftui"), //path for target to look for sources
        

    ]
)
