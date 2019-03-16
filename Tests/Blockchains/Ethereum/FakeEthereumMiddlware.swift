//
//  FakeEthereumMiddlware.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

@testable import BlockObserver
import XCTest

class FakeEthereumMiddlware: EthereumMiddlewareInterface {
    private var currentBlock: UInt64 = 1
    private var address: String
    
    init(address: String) {
        self.address = address
    }
    
    func getLastBlockNumber(lastBlock: @escaping (UInt64) -> Void) {
        lastBlock(currentBlock)
        currentBlock += 1
    }
    
    func getTransactionInBlockRange(from: UInt64, to: UInt64, transactions: @escaping ([EthereumTransaction]) -> Void) {
        transactions([EthereumTransaction(type: "test", blockHash: "test", transactionHash: "test", transactionIndex: "test", topics: ["test"], blockNumber: "test", address: address, transactionLogIndex: "test", logIndex: "test", removed: false, data: "test")])
    }
}
