//
//  StreamEncoder.swift
//  Encoding
//

/// Encodes a stream of `Element` returning `Partial` values when possible
public protocol StreamEncoder {
	associatedtype Element
	associatedtype Partial
	associatedtype Encoded
	
	/// Encode a sequence of `Element` and buffer the encoded value
	mutating func encode<T: Sequence>(_ elements: T) where T.Element == Element
	
	/// Encode a sequence of `Element` and return the buffered value
	mutating func encodePartial<T: Sequence>(_ elements: T) -> Partial where T.Element == Element
	
	/// Finalizes the encoder state and returns the buffered value
	///
	/// Finalizing consumes the StreamEncoder
	mutating func finalize() -> Encoded
}
