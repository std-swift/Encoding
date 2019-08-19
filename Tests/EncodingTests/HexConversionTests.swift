//
//  HexConversionTests.swift
//  EncodingTests
//

import XCTest
import Encoding

final class HexConversionTests: XCTestCase {
	func testHexString() {
		let array: Array<UInt8> = [0, 1, 2, 15, 16, 17, 31, 32, 33, 253, 254, 255]
		XCTAssertEqual(array.hexString, "0001020f10111f2021fdfeff")
		
		let contiguousarray: ContiguousArray<UInt8> = [0, 1, 2, 15, 16, 17, 31, 32, 33, 253, 254, 255]
		XCTAssertEqual(contiguousarray.hexString, "0001020f10111f2021fdfeff")
	}
	
	func testInitHex() {
		let array = Array<UInt8>(hexString: "0001020f10111f2021fdfeff")
		XCTAssertEqual(array, [0, 1, 2, 15, 16, 17, 31, 32, 33, 253, 254, 255])
		
		let contiguousarray = ContiguousArray<UInt8>(hexString: "0001020f10111f2021fdfeff")
		XCTAssertEqual(contiguousarray, [0, 1, 2, 15, 16, 17, 31, 32, 33, 253, 254, 255])
	}
	
	func testHexConversion() {
		let initial: [UInt8] = (0..<100).map { _ in UInt8.random(in: .min ... .max) }
		let string = initial.hexString
		let array = [UInt8](hexString: string)
		XCTAssertEqual(array, initial)
	}
}
