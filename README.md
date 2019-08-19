# Encoding

[![](https://img.shields.io/badge/Swift-5.0-orange.svg)][1]
[![](https://img.shields.io/badge/os-macOS%20|%20Linux-lightgray.svg)][1]
[![](https://travis-ci.com/std-swift/Encoding.svg?branch=master)][2]
[![](https://codecov.io/gh/std-swift/Encoding/branch/master/graph/badge.svg)][3]
[![](https://codebeat.co/badges/1f6e7353-6b43-436a-9459-583ddd7cc0fe)][4]

[1]: https://swift.org/download/#releases
[2]: https://travis-ci.com/std-swift/Encoding
[3]: https://codecov.io/gh/std-swift/Encoding
[4]: https://codebeat.co/projects/github-com-std-swift-encoding-master

Hex strings, endinanness, and bit packing

## Importing

```Swift
import Encoding
```

```Swift
dependencies: [
	.package(url: "https://github.com/std-swift/Encoding.git",
	         from: "1.1.0")
],
targets: [
	.target(
		name: "",
		dependencies: [
			"Encoding"
		]),
]
```

## Using

### `FixedWidthInteger`

- `littleEndianBytes: [UInt8]`
- `bigEndianBytes: [UInt8]`

### `Collection where Element == UInt8`

- `hexString: String`

### `RangeReplaceableCollection where Element == UInt8`

- `init?<S: StringProtocol>(hexString: S)`

### `Array where Element: BinaryInteger`

```Swift
func asArray<T: BinaryInteger>(endinanness: Endianness, sourceBits: Int, resultBits: Int) -> [T]
func asBigEndian<T: BinaryInteger>(sourceBits: Int = Element().bitWidth, resultBits: Int = T().bitWidth) -> [T]
func asLittleEndian<T: BinaryInteger>(sourceBits: Int = Element().bitWidth, resultBits: Int = T().bitWidth) -> [T]
```

### `ContiguousArray where Element: BinaryInteger`

Offers 15% better performance over the `Array` version

```Swift
func asArray<T: BinaryInteger>(endinanness: Endianness, sourceBits: Int, resultBits: Int) -> ContiguousArray<T>
func asBigEndian<T: BinaryInteger>(sourceBits: Int = Element().bitWidth, resultBits: Int = T().bitWidth) -> ContiguousArray<T>
func asLittleEndian<T: BinaryInteger>(sourceBits: Int = Element().bitWidth, resultBits: Int = T().bitWidth) -> ContiguousArray<T>
```

### `StreamDecoder`

```Swift
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
```

### `StreamEncoder`

```Swift
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
```
