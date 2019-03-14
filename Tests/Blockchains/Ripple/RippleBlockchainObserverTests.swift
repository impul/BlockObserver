//
//  RippleBlockchainObserverTests.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

@testable import BlockObserver
import XCTest

class RippleBlockchainObserverTests: XCTestCase, BlockchainObserverDelegate {
    var rippleBlockchain: RippleBlockchainObserver?
    var rippleMiddleware: RippleMiddlewareInterface?
    var receivingTransactionsExpectation: XCTestExpectation?
    
    override func setUp() {
        rippleMiddleware = FakeRippleMiddleware()
        rippleBlockchain = RippleBlockchainObserver(endpointMiddlware: rippleMiddleware!, delegate: self)
    }
    
    func testReceivingTransactionsFromMiddware() {
        receivingTransactionsExpectation = expectation(description: "Receive transaction")
        rippleBlockchain?.observe("test")
        wait(for: [receivingTransactionsExpectation!], timeout: 10)
    }
    
    // MARK: - BlockchainObserverDelegate
    
    func didReceive(newStatus: TransactionStatus, onObserver: BlockchainObserverInterface, address: Address, txId: String) {
        rippleBlockchain?.pauseObserving()
        receivingTransactionsExpectation?.fulfill()
    }
}
