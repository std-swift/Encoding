//
//  Array+HexString.swift
//  Encoding
//

@usableFromInline
internal let indexToHexMap: [Character] = [
	"0", "1", "2", "3", "4", "5", "6", "7",
	"8", "9", "a", "b", "c", "d", "e", "f"
]

extension Array where Element == UInt8 {
	@inlinable
	public var hexString: String {
		return String(self
			.flatMap { [$0 >> 4, $0 & 0x0F] }
			.map { indexToHexMap[Int($0)] }
		)
	}
}
