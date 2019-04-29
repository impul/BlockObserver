//
//  TestLogger.swift
//  Async
//
//  Created by Pavlo Boiko on 3/16/19.
//

@testable import BlockObserver
import XCTest


class TestLogger: TransactionNotifier {
    func log(_ transaction: Transaction) {
        testAction(transaction.txId)
    }
    
    let testAction: (String) -> Void
    
    init(testAction: @escaping (String) -> Void) {
        self.testAction = testAction
    }
}
