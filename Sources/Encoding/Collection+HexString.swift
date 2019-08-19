//
//  Collection+HexString.swift
//  Encoding
//

@usableFromInline
internal let indexToHexMap: [Character] = [
	"0", "1", "2", "3", "4", "5", "6", "7",
	"8", "9", "a", "b", "c", "d", "e", "f"
]

extension Collection where Element == UInt8 {
	@inlinable
	public var hexString: String {
		return String(self
			.flatMap { [$0 >> 4, $0 & 0x0F] }
			.map { indexToHexMap[Int($0)] }
		)
	}
}

extension RangeReplaceableCollection where Element == UInt8 {
	@inlinable
	public init?<S: StringProtocol>(hexString: S) {
		guard hexString.count % 2 == 0 else { return nil }
		self.init()
		let count = hexString.count >> 1
		self.reserveCapacity(count)
		var startIndex = hexString.startIndex
		var endIndex = startIndex
		for _ in 0..<count {
			endIndex = hexString.index(startIndex, offsetBy: 2)
			let elements = hexString[startIndex..<endIndex]
			guard let byte = UInt8(elements, radix: 16) else { return nil }
			self.append(byte)
			startIndex = endIndex
		}
	}
}
