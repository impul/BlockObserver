//
//  StackInterface.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/16/19.
//

import Foundation

public protocol TransactionsBufferInterfcae {
    associatedtype Element
    
    init(capacity: Int)
    
    func append(_ element: Element)
    var buffer: [Transaction] { get }
    var count: Int { get }
}
