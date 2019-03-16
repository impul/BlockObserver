//
//  BlockchainObserverTests.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

@testable import BlockObserver
import XCTest

fileprivate var address = "0xBB5933843c4b4Ed2570344B7E1031974E07Ea52c"

class BlockchainObserverTests: XCTestCase, BlockchainObserverDelegate {
    var ethereumBlockchain: EthereumBlockchainObserver?
    var ethereumMiddlware: EthereumMiddlewareInterface?
    var receivingTransactionsExpectation: XCTestExpectation?
    
    override func setUp() {
        ethereumMiddlware = FakeEthereumMiddlware(address: address)
        ethereumBlockchain = EthereumBlockchainObserver(endpointMiddlware: ethereumMiddlware!, delegate: self)
    }
    
    func testReceivingTransactionsFromMiddware() {
        receivingTransactionsExpectation = expectation(description: "Receive transaction")
        ethereumBlockchain?.observe(address)
        wait(for: [receivingTransactionsExpectation!], timeout: 10)
    }
    
    // MARK: - BlockchainObserverDelegate
    
    func didReceive(newStatus: TransactionStatus, onObserver: BlockchainObserverInterface, address: Address, txId: String) {
        XCTAssertEqual(address, address)
        ethereumBlockchain?.pauseObserving()
        receivingTransactionsExpectation?.fulfill()
    }
}
