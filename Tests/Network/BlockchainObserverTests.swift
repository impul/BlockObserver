//
//  BlockchainObserverTests.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

@testable import BlockObserver
import XCTest

fileprivate var address0 = "0xBB5933843c4b4Ed2570344B7E1031974E07Ea52c"
fileprivate var address1 = "0xBB5933843c4b4Ed2570344B7E1031974E07Ea52d"
fileprivate var address2 = "0xBB5933843c4b4Ed2570344B7E1031974E07Ea52e"
fileprivate var address3 = "0xBB5933843c4b4Ed2570344B7E1031974E07Ea52d"

class BlockchainObserverTests: XCTestCase, BlockchainObserverDelegate {
    var ethereumBlockchain: EthereumBlockchainObserver?
    var ethereumMiddlware: EthereumMiddlewareInterface?
    var receivingTransactionsExpectation: XCTestExpectation?
    
    override func setUp() {
        ethereumMiddlware = FakeEthereumMiddlware()
        ethereumBlockchain = EthereumBlockchainObserver(endpointMiddlware: ethereumMiddlware!, delegate: self)
    }
    
    func testDefaultEthereumBlockchainObserver() {
        ethereumBlockchain?.observe(address0)
        ethereumBlockchain?.observe(address0)
        XCTAssertEqual(ethereumBlockchain?.observedAddresses.count, 1)
        XCTAssertEqual(ethereumBlockchain?.isUpdating, true)
        ethereumBlockchain?.removeObserver(address0)
        XCTAssertEqual(ethereumBlockchain?.observedAddresses.count, 0)
        XCTAssertEqual(ethereumBlockchain?.isUpdating, false)
        ethereumBlockchain?.removeObserver(address0)
        XCTAssertEqual(ethereumBlockchain?.observedAddresses.count, 0)
        XCTAssertEqual(ethereumBlockchain?.isUpdating, false)
        ethereumBlockchain?.observe(address0)
        ethereumBlockchain?.observe(address1)
        ethereumBlockchain?.observe(address2)
        XCTAssertEqual(ethereumBlockchain?.observedAddresses.count, 3)
        XCTAssertEqual(ethereumBlockchain?.isUpdating, true)
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
