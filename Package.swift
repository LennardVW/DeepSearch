// swift-tools-version:6.0
// DeepSearch - Semantic file search

import PackageDescription

let package = Package(
    name: "DeepSearch",
    platforms: [.macOS(.v15)],
    products: [.executable(name: "deepsearch", targets: ["DeepSearch"])],
    targets: [.executableTarget(name: "DeepSearch", swiftSettings: [.swiftLanguageMode(.v6)])]
)
