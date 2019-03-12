//
//  StreamCodingTests.swift
//  Encoding
//

import XCTest
import Encoding

struct SumEncoder: StreamEncoder {
	typealias Element = Int
	typealias Partial = Element
	typealias Encoded = Element
	
	private var value: Element = 0
	
	mutating func encode<T: Sequence>(_ elements: T) where T.Element == Element {
		self.value = elements.reduce(self.value, +)
	}
	
	mutating func encodePartial<T: Sequence>(_ elements: T) -> Partial where T.Element == Element {
		self.value = elements.reduce(self.value, +)
		return self.value
	}
	
	func finalize() -> Encoded {
		return self.value
	}
}

struct SumDecoder: StreamDecoder {
	typealias Element = Int
	typealias Partial = Element
	typealias Decoded = Element
	
	private var value: Element = 0
	
	mutating func decode<T: Sequence>(_ elements: T) where T.Element == Element {
		self.value = elements.reduce(self.value, +)
	}
	
	mutating func decodePartial<T: Sequence>(_ elements: T) -> Partial where T.Element == Element {
		self.value = elements.reduce(self.value, +)
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
