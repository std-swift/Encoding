//
//  StreamDecoder.swift
//  Encoding
//

/// Decodes a stream of `Element` returning `Partial` values when possible
public protocol StreamDecoder {
	associatedtype Encoded
	associatedtype Partial
	associatedtype Decoded
	
	/// Decode and buffer
	mutating func decode(_ encoded: Encoded)
	
	/// Decode and return (and empty) the buffered value
	mutating func decodePartial(_ encoded: Encoded) -> Partial
	
	/// Finalizes the decoder state and returns the buffered value
	///
	/// Finalizing consumes the StreamDecoder
	mutating func finalize() -> Decoded
}
