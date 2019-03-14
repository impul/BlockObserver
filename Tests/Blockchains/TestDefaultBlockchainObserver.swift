//
//  TestDefaultBlockchainObserver.swift
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

class TestDefaultBlockchainObserver: XCTestCase, BlockchainObserverDelegate {
    var defaultBlockchain: DefaultBlockchainObserver?
    
    override func setUp() {
        defaultBlockchain = EthereumBlockchainObserver(delegate: self)
    }
    
    func testDefaultEthereumBlockchainObserver() {
        defaultBlockchain?.observe(address0)
        defaultBlockchain?.observe(address0)
        XCTAssertEqual(defaultBlockchain?.observedAddresses.count, 1)
        XCTAssertEqual(defaultBlockchain?.isUpdating, true)
        defaultBlockchain?.removeObserver(address0)
        XCTAssertEqual(defaultBlockchain?.observedAddresses.count, 0)
        XCTAssertEqual(defaultBlockchain?.isUpdating, false)
        defaultBlockchain?.removeObserver(address0)
        XCTAssertEqual(defaultBlockchain?.observedAddresses.count, 0)
        XCTAssertEqual(defaultBlockchain?.isUpdating, false)
        defaultBlockchain?.observe(address0)
        defaultBlockchain?.observe(address1)
        defaultBlockchain?.observe(address2)
        XCTAssertEqual(defaultBlockchain?.observedAddresses.count, 3)
        XCTAssertEqual(defaultBlockchain?.isUpdating, true)
    }
    
    func didReceive(newStatus: TransactionStatus, onObserver: BlockchainObserverInterface, address: Address, txId: String) {
        
    }
}
