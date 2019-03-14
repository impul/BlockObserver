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
    private var currentBlock: UInt32 = 1
    
    func getLastBlockNumber(lastBlock: @escaping (UInt32) -> Void) {
        lastBlock(currentBlock)
        currentBlock += 1
    }
    
    func getTransactionInBlockRange(from: UInt32, to: UInt32, transactions: @escaping ([EthereumTransaction]) -> Void) {
        transactions([EthereumTransaction(type: "test", blockHash: "test", transactionHash: "test", transactionIndex: "test", topics: ["test"], blockNumber: "test", address: "test", transactionLogIndex: "test", logIndex: "test", removed: false, data: "test")])
    }
}
