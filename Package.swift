// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Sappi",
  platforms: [.macOS(.v10_15)],
  products: [
    .executable(name: "sappi", targets: ["sappi"]),
    .library(name: "SappiKit", targets: ["SappiKit"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.3.0")

  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "sappi", dependencies: [
        "SappiKit",
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ]
    ),
    .target(
      name: "SappiKit", dependencies: [
      ]
    ),
    .testTarget(
      name: "SappiTests",
      dependencies: ["sappi"]
    )
  ]
)
