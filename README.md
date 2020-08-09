# Encoding

[![](https://img.shields.io/badge/Swift-5.1--5.3-orange.svg)][1]
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

Add the following line to the dependencies in your `Package.swift` file:

```Swift
.package(url: "https://github.com/std-swift/Encoding.git", from: "3.0.0")
```

Add `Encoding` as a dependency for your target:

```swift
.product(name: "Encoding", package: "Encoding"),
```

and finally,

```Swift
import Encoding
```
