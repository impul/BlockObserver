//
//  StackInterface.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/16/19.
//

import Foundation

public protocol TransactionsBufferInterfce {
    init(capacity: Int)

    func append(_ element: Transaction)
    var transactions: [Transaction] { get }
    var count: Int { get }
}
