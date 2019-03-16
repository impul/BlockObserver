//
//  TransactionsBuffer.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/16/19.
//

import Foundation

class TransactionsBuffer: TransactionsBufferInterfce {
    private var bufferContainer: [Transaction] = []
    private var capacity: Int
    
    required init(capacity: Int) {
        self.capacity = capacity
    }
    
    func append(_ element: Transaction) {
        self.bufferContainer.append(element)
        if count > capacity {
            bufferContainer.removeFirst(count - capacity)
        }
    }
    
    var transactions: [Transaction] {
        return bufferContainer.reversed()
    }
    
    var count: Int {
        return bufferContainer.count
    }
}
