//
//  TransactionNotifier.swift
//  Async
//
//  Created by Pavlo Boiko on 3/17/19.
//

import Foundation

public protocol TransactionNotifier {
    func log(_ transaction: Transaction)
}
