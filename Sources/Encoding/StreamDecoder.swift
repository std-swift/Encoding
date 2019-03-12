//
//  StreamDecoder.swift
//  Encoding
//

/// Decodes a stream of `Element` returning `Partial` values when possible
public protocol StreamDecoder {
	associatedtype Element
	associatedtype Partial
	associatedtype Decoded
	
	/// Decode a sequence of `Element` and buffer the decoded value
	mutating func decode<T: Sequence>(_ elements: T) where T.Element == Element
	
	/// Decode a sequence of `Element` and return the buffered value
	mutating func decodePartial<T: Sequence>(_ elements: T) -> Partial where T.Element == Element
	
	/// Finalizes the decoder state and returns the buffered value
	///
	/// Finalizing consumes the StreamDecoder
	mutating func finalize() -> Decoded
}
