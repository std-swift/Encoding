//
//  StreamEncoder.swift
//  Encoding
//

/// Encodes a stream of `Element` returning `Partial` values when possible
public protocol StreamEncoder {
	associatedtype Decoded
	associatedtype Partial
	associatedtype Encoded
	
	/// Encode and buffer
	mutating func encode(_ decoded: Decoded)
	
	/// Encode and return (and empty) the buffered value
	mutating func encodePartial(_ decoded: Decoded) -> Partial
	
	/// Finalizes the encoder state and returns the buffered value
	///
	/// Finalizing consumes the StreamEncoder
	mutating func finalize() -> Encoded
}
