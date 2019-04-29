//
//  PrintLogger.swift
//  Async
//
//  Created by Pavlo Boiko on 3/17/19.
//

import Foundation

public class BlockPrintLogger: TransactionNotifier {
    public func log(_ transaction: Transaction) {
        Swift.print(transaction.txId)
    }
}
