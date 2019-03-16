//
//  TransactionsBuffer.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/16/19.
//

@testable import BlockObserver
import XCTest

class  TransactionsBufferTests: XCTestCase {

    func testTransactionStack() {
        let element1 = Transaction(asset: .ethereum, txId: "1", receiverAddress: "test")
        let element2 = Transaction(asset: .ethereum, txId: "2", receiverAddress: "test")
        let element3 = Transaction(asset: .ethereum, txId: "3", receiverAddress: "test")
        let buffer = TransactionsBuffer(capacity: 2)
        buffer.append(element1)
        buffer.append(element2)
        buffer.append(element3)
        XCTAssertEqual(buffer.count, 2)
        XCTAssertEqual(buffer.buffer[0].txId, "3")
        XCTAssertEqual(buffer.buffer[1].txId, "2")
    }
}
