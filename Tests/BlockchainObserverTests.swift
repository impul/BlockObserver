//
//  BlockchainObserverTests.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/16/19.
//

@testable import BlockObserver
@testable import Logging
import XCTest

fileprivate var address = "0xBB5933843c4b4Ed2570344B7E1031974E07Ea52c"

class TestBlockObserver: XCTestCase {
    var blockchainObserver: BlockObserver?
    
    func testBlockObserver() {
        let expect = expectation(description: "Info received")
        let logger = TestLogger(testAction: { info in
            self.blockchainObserver?.stopObservers()
            XCTAssertEqual("Did receive tx to \(address), with txId test", info)
            expect.fulfill()
        })
        let middleware = FakeEthereumMiddlware(address: address)
        let ethereumBlockchainObserver = EthereumBlockchainObserver(endpointMiddlware: middleware, delegate: nil)
        blockchainObserver = BlockObserver(blockchainsObservers: [ethereumBlockchainObserver],
                                           buffer: TransactionsBuffer(capacity: 50),
                                           logger: logger)
        ethereumBlockchainObserver.delegate = blockchainObserver
        blockchainObserver?.addObserver(for: address, asset: .ethereum)
        wait(for: [expect], timeout: 10)
    }
}

