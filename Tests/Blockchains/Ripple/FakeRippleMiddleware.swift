//
//  FakeRippleMiddleware.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/14/19.
//  Copyright © 2019 Pavlo Boiko. All rights reserved.
//

@testable import BlockObserver
import XCTest

class FakeRippleMiddleware: RippleMiddlewareInterface {
    private var currentBlock: UInt64 = 1
    private var account: String
    
    init(account: String) {
        self.account = account
    }
    
    func getLastBlockNumber(lastBlock: @escaping (UInt64) -> Void) {
        lastBlock(currentBlock)
        currentBlock += 1
    }
    
    func getTransactionInBlockRange(byBlock: UInt64, transactions: @escaping ([RippleTransaction]) -> Void) {
        transactions([RippleTransaction(hash: "test", tx: .init(Account: account))])
    }
}
