// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "WebPortal",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "WebPortal",
            targets: ["WebPortal"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/ionic-portals-ios.git", from: "0.6.4"),
    ],
    targets: [
        .target(
            name: "WebPortal",
            dependencies: [
                .product(name: "IonicPortals", package: "ionic-portals-ios"),
            ],
            path: "WebPortal"
        ),
    ]
)
