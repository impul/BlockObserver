[![Build Status](https://travis-ci.com/impul/BlockObserver.svg?branch=develop)](https://travis-ci.com/impul/BlockObserver)
[![Badge w/ Version](https://cocoapod-badges.herokuapp.com/v/BlockObserver/badge.png)](https://cocoadocs.org/docsets/BlockObserver)
[![Badge w/ Platform](https://cocoapod-badges.herokuapp.com/p/BlockObserver/badge.svg)](https://cocoadocs.org/docsets/BlockObserver)
[![Badge w/ Licence](https://cocoapod-badges.herokuapp.com/l/BlockObserver/badge.svg)](https://cocoadocs.org/docsets/BlockObserver)

# BlockObserver
Simple scalable blockchain observer

## Features
- Observe Ethereum
- Observe Ripple

## Installation
### Swift Package Manager
To include BlockObserver using  [Swift Package Manager](https://swift.org/package-manager/) add this line to your Package.swift
```Swift
 dependencies: [
 .package(url: "https://github.com/impul/BlockObserver.git", from: "0.1.5")
 ]
```

### CocoaPods
<p>To integrate BlockObserver into your Xcode project using <a href="http://cocoapods.org">CocoaPods</a>, specify it in your <code>Podfile</code>:</p>
<pre><code class="ruby language-ruby">pod 'BlockObserver'</code></pre>

### Carthage
To include BlockObserver using [Carthage](https://github.com/Carthage/Carthage), simply add this in your `Cartfile`:
```ruby
github "impul/BlockObserver"
```
## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.
## How to use

### There is three ways to init BlockObserver
#### Default way, use embedded blockchain observers
```swift
let blockObserver = BlockObserver(assets: [.ethereum, .ripple])
blockObserver.addObserver(for: "0xB29f7E1AB952CF2770D56712e4667680F55359eb", asset: .ethereum)
```
#### Use your own Blockchain Observers
```swift
let myEhtereumObserver: BlockchainObserverInterface = RippleBlockchainObserver()
let myRippleObserver: BlockchainObserverInterface = EthereumBlockchainObserver()
let buffer: TransactionsBufferInterfce = TransactionsBuffer(capacity: 100)
let looger: Logger = PrintLoger()
let blockObserver = BlockObserver(blockchainsObservers: [myEhtereumObserver, myRippleObserver],
                                  buffer: buffer,
                                  logger: looger)
myEhtereumObserver.delegate = blockObserver
myRippleObserver.delegate = blockObserver
```
#### If you do not create own .init in your blockchain observers, you can use simpler init
```swift
let buffer: TransactionsBufferInterfce = TransactionsBuffer(capacity: 100)
let looger: Logger = PrintLoger()
let blockObserver = BlockObserver(blockchainsObservers: [RippleBlockchainObserver.self, RippleBlockchainObserver.self],
buffer: buffer,
logger: looger)
```
### Add observer
```swift
blockObserver.addObserver(for: "0xB29f7E1AB952CF2770D56712e4667680F55359eb", asset: .ethereum)
```
### Remove observer
```swift
blockObserver.removeObserver(for: "0xB29f7E1AB952CF2770D56712e4667680F55359eb", asset: .ethereum)
```
### That's all, now you can check your transactions when you want:
```swift
print(blockObserver.transactions)
```
## License
BlockOberver is released under the [MIT License](https://github.com/impul/BlockObserver/blob/master/LICENSE.md).
