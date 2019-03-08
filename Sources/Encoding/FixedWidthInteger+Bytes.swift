//
//  FixedWidthInteger+Bytes.swift
//  Encoding
//

extension FixedWidthInteger {
	@inlinable
	public var littleEndianBytes: [UInt8] {
		return withUnsafeBytes(of: self.littleEndian, Array.init)
	}
	
	@inlinable
	public var bigEndianBytes: [UInt8] {
		return withUnsafeBytes(of: self.bigEndian, Array.init)
	}
}
