//
//  StreamCodingTests.swift
//  Encoding
//

import XCTest
import Encoding

struct SumEncoder: StreamEncoder {
	typealias Decoded = [Int]
	typealias Partial = Int
	typealias Encoded = Int
	
	private var value: Int = 0
	
	mutating func encode(_ decoded: Decoded) {
		self.value = decoded.reduce(self.value, +)
	}
	
	mutating func encodePartial(_ decoded: Decoded) -> Partial {
		self.value = decoded.reduce(self.value, +)
		return self.value
	}
	
	func finalize() -> Encoded {
		return self.value
	}
}

struct SumDecoder: StreamDecoder {
	typealias Encoded = [Int]
	typealias Partial = Int
	typealias Decoded = Int
	
	private var value: Int = 0
	
	mutating func decode(_ encoded: Encoded) {
		self.value = encoded.reduce(self.value, +)
	}
	
	mutating func decodePartial(_ encoded: Encoded) -> Partial {
		self.value = encoded.reduce(self.value, +)
		return self.value
	}
	
	mutating func finalize() -> Decoded {
		return self.value
	}
}

final class StreamCodingTests: XCTestCase {
	func testStreamEncoder() {
		var encoder = SumEncoder()
		XCTAssertEqual(encoder.finalize(), 0)
		encoder.encode([1,2,3])
		XCTAssertEqual(encoder.finalize(), 6)
		XCTAssertEqual(encoder.encodePartial([1,2,3]), 12)
		XCTAssertEqual(encoder.finalize(), 12)
	}
	
	func testStreamDecoder() {
		var decoder = SumDecoder()
		XCTAssertEqual(decoder.finalize(), 0)
		decoder.decode([1,2,3])
		XCTAssertEqual(decoder.finalize(), 6)
		XCTAssertEqual(decoder.decodePartial([1,2,3]), 12)
		XCTAssertEqual(decoder.finalize(), 12)
	}
}
