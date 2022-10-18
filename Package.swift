// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IPaIndicator",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "IPaIndicator",
            targets: ["IPaIndicator"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ipapamagic/IPaDownloadManager.git", from: "1.4.0"),
        .package(url: "https://github.com/ipapamagic/IPaURLResourceUI.git", from: "5.4.0")
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "IPaIndicator",
            dependencies: [.product(name: "IPaDownloadManager", package: "IPaDownloadManager"),
                           .product(name: "IPaURLResourceUI", package: "IPaURLResourceUI")],
            path:"Sources/IPaIndicator"),
        .testTarget(
            name: "IPaIndicatorTests",
            dependencies: ["IPaIndicator"]),
    ]
)
