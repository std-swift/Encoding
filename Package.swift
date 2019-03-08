// swift-tools-version:5.0
//
//  Package.swift
//  Encoding
//

import PackageDescription

let package = Package(
	name: "Encoding",
	products: [
		.library(
			name: "Encoding",
			targets: ["Encoding"]),
	],
	targets: [
		.target(
			name: "Encoding",
			dependencies: []),
		.testTarget(
			name: "EncodingTests",
			dependencies: ["Encoding"]),
	]
)
