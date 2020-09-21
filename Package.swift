// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sappi",
    platforms: [.macOS(.v10_15)],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.3.0"),
      .package(url: "https://github.com/alqemyst/perfect-sysinfo.git", .branch("master")),
      .package(name: "NetUtils", url: "https://github.com/ivirtex/swift-netutils.git", from: "4.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "sappi", dependencies: [
              .product(name: "PerfectSysInfo", package: "perfect-sysinfo"),
              .product(name: "ArgumentParser", package: "swift-argument-parser"),
              "NetUtils"
              
          ]),
        .testTarget(
            name: "sappiTests",
            dependencies: ["sappi"]),
    ]
)
