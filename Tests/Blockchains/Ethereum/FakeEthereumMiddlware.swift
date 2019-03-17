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
    
    func getTransactionsInBlock(block: UInt64, transactions: @escaping ([EthereumTransaction]) -> Void) {
        transactions([EthereumTransaction(from: "test", blockHash: "test", value: "test", blockNumber: "test", to: address, input: "test")])
    }
}
