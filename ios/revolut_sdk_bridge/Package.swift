// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "revolut_sdk_bridge",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "revolut-sdk-bridge", targets: ["revolut_sdk_bridge"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(
            url: "https://bitbucket.org/revolut/revolut-payments-ios.git",
            exact: "3.18.0"
        )
    ],
    targets: [
        .target(
            name: "revolut_sdk_bridge",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "RevolutPayments", package: "revolut-payments-ios"),
                .product(name: "RevolutPay", package: "revolut-payments-ios")
            ],
            resources: [.process("PrivacyInfo.xcprivacy")]
        )
    ]
)
