// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "AirbnbSwift",
  platforms: [.macOS(.v10_13)],
  products: [
    .plugin(name: "FormatSwift", targets: ["FormatSwift"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.3"),
  ],
  targets: [
    .plugin(
      name: "FormatSwift",
      capability: .command(
        intent: .custom(
          verb: "format",
          description: "Formats Swift source files according to the Airbnb Swift Style Guide"),
        permissions: [
          .writeToPackageDirectory(reason: "Format Swift source files"),
        ]),
      dependencies: [
        "AirbnbSwiftFormatTool",
        "swiftformat",
        "SwiftLintBinary",
      ]),

    .executableTarget(
      name: "AirbnbSwiftFormatTool",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ],
      resources: [
        .process("airbnb.swiftformat"),
        .process("swiftlint.yml"),
      ]),

    .testTarget(
      name: "AirbnbSwiftFormatToolTests",
      dependencies: ["AirbnbSwiftFormatTool"]),

    .binaryTarget(
      name: "swiftformat",
      url: "https://github.com/calda/SwiftFormat-nightly/releases/download/2025-05-08-b/SwiftFormat.artifactbundle.zip",
      checksum: "ce079f8a7c8d8ba2f9d6aa461367808b2d56b99739b0791946ed23059da88017"),

    .binaryTarget(
      name: "SwiftLintBinary",
      url: "https://github.com/realm/SwiftLint/releases/download/0.63.1/SwiftLintBinary.artifactbundle.zip",
      checksum: "bcf27be3bd708d45f3f17ad497b48b2fa0302eaec15f4fbfd35cf01f126fc099"),
  ])
