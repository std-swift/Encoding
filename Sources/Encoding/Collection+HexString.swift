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
		var string = ""
		string.reserveCapacity(self.count << 1)
		for element in self {
			string.append(indexToHexMap[Int(element >> 4)])
			string.append(indexToHexMap[Int(element & 0x0F)])
		}
		return string
	}
}

extension RangeReplaceableCollection where Element == UInt8 {
	@inlinable
	public init?<S: StringProtocol>(hexString: S) {
		guard hexString.count % 2 == 0 else { return nil }
		let count = hexString.count >> 1
		self.init()
		self.reserveCapacity(count)
		var index = hexString.startIndex
		while index != hexString.endIndex {
			guard let high = hexString[index].hexDigitValue else { return nil }
			index = hexString.index(after: index)
			guard let low = hexString[index].hexDigitValue else { return nil }
			index = hexString.index(after: index)
			self.append(UInt8((high << 4) | low))
		}
	}
}
