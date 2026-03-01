// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KinderMap",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .executable(name: "KinderMap", targets: ["KinderMap"])
    ],
    targets: [
        .executableTarget(
            name: "KinderMap",
            path: ".",
            exclude: ["README.md", ".vscode"],
            sources: ["App", "Model", "Protocol", "Services", "ViewModel", "Views", "Resources"]
        )
    ]
)
