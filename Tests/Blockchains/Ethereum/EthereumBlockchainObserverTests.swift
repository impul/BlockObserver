//
//  BlockchainObserverTests.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

@testable import BlockObserver
import XCTest

class BlockchainObserverTests: XCTestCase, BlockchainObserverDelegate {
    var ethereumBlockchain: EthereumBlockchainObserver?
    var ethereumMiddlware: EthereumMiddlewareInterface?
    var receivingTransactionsExpectation: XCTestExpectation?
    
    override func setUp() {
        ethereumMiddlware = FakeEthereumMiddlware()
        ethereumBlockchain = EthereumBlockchainObserver(endpointMiddlware: ethereumMiddlware!, delegate: self)
    }
    
    func testReceivingTransactionsFromMiddware() {
        receivingTransactionsExpectation = expectation(description: "Receive transaction")
        ethereumBlockchain?.observe("test")
        wait(for: [receivingTransactionsExpectation!], timeout: 10)
    }
    
    // MARK: - BlockchainObserverDelegate
    
    func didReceive(newStatus: TransactionStatus, onObserver: BlockchainObserverInterface, address: Address, txId: String) {
        ethereumBlockchain?.pauseObserving()
        receivingTransactionsExpectation?.fulfill()
    }
}
