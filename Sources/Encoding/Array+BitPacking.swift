//
//  Array+BitPacking.swift
//  Encoding
//

public enum Endianness {
	case big
	case little
}

extension Array where Element: BinaryInteger {
	/// Converts an array of `BinaryInteger` from one type to another but
	/// assuming only `sourceBits` and `destinationBits` number of bits are
	/// used. Any bits above that count are ignored and lost.
	///
	/// - Precondition: `sourceBits > 0`
	/// - Precondition: `resultBits > 0`
	/// - Precondition: `0 < sourceBits <= Element().bitWidth`
	/// - Precondition: `0 < resultBits <= T().bitWidth`
	///
	/// - Note: The sign of the input/output has no importance. Only the binary
	///         representation matters
	///
	/// - Note: Endianness is only considered in the case of multiple elements.
	///         If `self` is a `[UInt16]`, each `UInt16` is treated as a single
	///         big endian value. The result values are treated similarly.
	///
	/// - Parameter sourceBits: The number of bits from each source word to use
	/// - Parameter resultBits: The number of bits in each result word to fill
	@inlinable
	public func asBigEndian<T: BinaryInteger>(sourceBits: Int = Element().bitWidth,
	                                          resultBits: Int = T().bitWidth) -> [T] {
		return self.asArray(endinanness: .big,
		                    sourceBits: sourceBits,
		                    resultBits: resultBits)
	}
	
	/// Converts an array of `BinaryInteger` from one type to another but
	/// assuming only `sourceBits` and `destinationBits` number of bits are
	/// used. Any bits above that count are ignored and lost.
	///
	/// - Precondition: `sourceBits > 0`
	/// - Precondition: `resultBits > 0`
	/// - Precondition: `0 < sourceBits <= Element().bitWidth`
	/// - Precondition: `0 < resultBits <= T().bitWidth`
	///
	/// - Note: The sign of the input/output has no importance. Only the binary
	///         representation matters
	///
	/// - Note: Endianness is only considered in the case of multiple elements.
	///         If `self` is a `[UInt16]`, each `UInt16` is treated as a single
	///         big endian value. The result values are treated similarly.
	///
	/// - Parameter sourceBits: The number of bits from each source word to use
	/// - Parameter resultBits: The number of bits in each result word to fill
	@inlinable
	public func asLittleEndian<T: BinaryInteger>(sourceBits: Int = Element().bitWidth,
	                                             resultBits: Int = T().bitWidth) -> [T] {
		return self.asArray(endinanness: .little,
		                    sourceBits: sourceBits,
		                    resultBits: resultBits)
	}
	
	/// Performs the conversion for `.asBigEndian` and `.asLittleEndian`
	///
	/// - Precondition: `sourceBits > 0`
	/// - Precondition: `resultBits > 0`
	/// - Precondition: `0 < sourceBits <= Element().bitWidth`
	/// - Precondition: `0 < resultBits <= T().bitWidth`
	@inlinable
	public func asArray<T: BinaryInteger>(endinanness: Endianness,
	                                      sourceBits: Int = Element().bitWidth,
	                                      resultBits: Int = T().bitWidth) -> [T] {
		precondition(sourceBits > 0)
		precondition(resultBits > 0)
		precondition(sourceBits <= Element().bitWidth)
		precondition(resultBits <= T().bitWidth)
		
		let resultCount = (self.count*sourceBits + resultBits - 1) / resultBits
		if resultCount == 0 { return [] }
		let contiguous = ContiguousArray<T>(unsafeUninitializedCapacity: resultCount) { (buffer, count) in
			count = resultCount // Required by the initializer
			
			var resultIndex = 0
			var resultBitIndex = resultBits
			
			buffer[0] = 0
			for word in self {
				var sourceBitIndex = 0
				while sourceBitIndex < sourceBits {
					if resultBitIndex == 0 {
						resultBitIndex = resultBits
						resultIndex += 1
						buffer[resultIndex] = 0
					}
					let bitCount: Int
					let bits: T
					switch endinanness {
						case .big:
							let calcSBI = sourceBits - sourceBitIndex
							bitCount = Swift.min(resultBitIndex, calcSBI)
							bits = T(word >> (calcSBI - bitCount)) & ~(~T(0) << bitCount)
							buffer[resultIndex] |= bits << (resultBitIndex - bitCount)
						case .little:
							bitCount = Swift.min(resultBitIndex, sourceBits - sourceBitIndex)
							bits = T(word >> sourceBitIndex) & ~(~T(0) << bitCount)
							buffer[resultIndex] |= bits << (resultBits - resultBitIndex)
					}
					resultBitIndex -= bitCount
					sourceBitIndex += bitCount
				}
			}
		}
		return [T](contiguous)
	}
}

extension ContiguousArray where Element: BinaryInteger {
	/// Converts an array of `BinaryInteger` from one type to another but
	/// assuming only `sourceBits` and `destinationBits` number of bits are
	/// used. Any bits above that count are ignored and lost.
	///
	/// - Precondition: `sourceBits > 0`
	/// - Precondition: `resultBits > 0`
	/// - Precondition: `0 < sourceBits <= Element().bitWidth`
	/// - Precondition: `0 < resultBits <= T().bitWidth`
	///
	/// - Note: The sign of the input/output has no importance. Only the binary
	///         representation matters
	///
	/// - Note: Endianness is only considered in the case of multiple elements.
	///         If `self` is a `[UInt16]`, each `UInt16` is treated as a single
	///         big endian value. The result values are treated similarly.
	///
	/// - Parameter sourceBits: The number of bits from each source word to use
	/// - Parameter resultBits: The number of bits in each result word to fill
	@inlinable
	public func asBigEndian<T: BinaryInteger>(sourceBits: Int = Element().bitWidth,
	                                          resultBits: Int = T().bitWidth) -> ContiguousArray<T> {
		return self.asArray(endinanness: .big,
		                    sourceBits: sourceBits,
		                    resultBits: resultBits)
	}
	
	/// Converts an array of `BinaryInteger` from one type to another but
	/// assuming only `sourceBits` and `destinationBits` number of bits are
	/// used. Any bits above that count are ignored and lost.
	///
	/// - Precondition: `sourceBits > 0`
	/// - Precondition: `resultBits > 0`
	/// - Precondition: `0 < sourceBits <= Element().bitWidth`
	/// - Precondition: `0 < resultBits <= T().bitWidth`
	///
	/// - Note: The sign of the input/output has no importance. Only the binary
	///         representation matters
	///
	/// - Note: Endianness is only considered in the case of multiple elements.
	///         If `self` is a `[UInt16]`, each `UInt16` is treated as a single
	///         big endian value. The result values are treated similarly.
	///
	/// - Parameter sourceBits: The number of bits from each source word to use
	/// - Parameter resultBits: The number of bits in each result word to fill
	@inlinable
	public func asLittleEndian<T: BinaryInteger>(sourceBits: Int = Element().bitWidth,
	                                             resultBits: Int = T().bitWidth) -> ContiguousArray<T> {
		return self.asArray(endinanness: .little,
		                    sourceBits: sourceBits,
		                    resultBits: resultBits)
	}
	
	/// Performs the conversion for `.asBigEndian` and `.asLittleEndian`
	///
	/// - Precondition: `sourceBits > 0`
	/// - Precondition: `resultBits > 0`
	/// - Precondition: `0 < sourceBits <= Element().bitWidth`
	/// - Precondition: `0 < resultBits <= T().bitWidth`
	@inlinable
	public func asArray<T: BinaryInteger>(endinanness: Endianness,
	                                      sourceBits: Int = Element().bitWidth,
	                                      resultBits: Int = T().bitWidth) -> ContiguousArray<T> {
		precondition(sourceBits > 0)
		precondition(resultBits > 0)
		precondition(sourceBits <= Element().bitWidth)
		precondition(resultBits <= T().bitWidth)
		
		let resultCount = (self.count*sourceBits + resultBits - 1) / resultBits
		if resultCount == 0 { return [] }
		return ContiguousArray<T>(unsafeUninitializedCapacity: resultCount) { (buffer, count) in
			count = resultCount // Required by the initializer
			
			var resultIndex = 0
			var resultBitIndex = resultBits
			
			buffer[0] = 0
			for word in self {
				var sourceBitIndex = 0
				while sourceBitIndex < sourceBits {
					if resultBitIndex == 0 {
						resultBitIndex = resultBits
						resultIndex += 1
						buffer[resultIndex] = 0
					}
					let bitCount: Int
					let bits: T
					switch endinanness {
						case .big:
							let calcSBI = sourceBits - sourceBitIndex
							bitCount = Swift.min(resultBitIndex, calcSBI)
							bits = T(word >> (calcSBI - bitCount)) & ~(~T(0) << bitCount)
							buffer[resultIndex] |= bits << (resultBitIndex - bitCount)
						case .little:
							bitCount = Swift.min(resultBitIndex, sourceBits - sourceBitIndex)
							bits = T(word >> sourceBitIndex) & ~(~T(0) << bitCount)
							buffer[resultIndex] |= bits << (resultBits - resultBitIndex)
					}
					resultBitIndex -= bitCount
					sourceBitIndex += bitCount
				}
			}
		}
	}
}
