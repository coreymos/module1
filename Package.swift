// swift-tools-version:5.5
import PackageDescription

let package = Package(
	name: "module1",
	products: [
		.executable(name: "module1", targets: ["module1"]),
	],
	dependencies: [],
	targets: [
		.executableTarget(name: "module1", dependencies: [])
	]
)
