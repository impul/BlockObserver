//
//  EthereumMiddlwareTests.swift
//  Tests
//
//  Created by Pavlo Boiko on 3/16/19.
//

import Foundation

@testable import BlockObserver
import XCTest

struct TestCodableModel: Codable {
    var test: String
}

class EthereumMiddlwareTests: XCTestCase {
    var ethereumMiddlware: EthereumMiddlewareInterface?
    
    override func setUp() {
        ethereumMiddlware = nil
    }
    
    func testEthereumMiddlewareNewBlockSuccesResult() {
        let expect = expectation(description: "Succes request")
        
        let modelString = "{\"jsonrpc\":\"2.0\",\"id\":0, \"result\": \"0x1\"}"
        let data = Data(modelString.utf8)
        let networkManager = FakeSuccessNetworkManager(model: data)
        ethereumMiddlware = EthereumMiddleware(networkManager: networkManager)
        ethereumMiddlware?.getLastBlockNumber(lastBlock: { (number) in
            
            XCTAssertEqual(number, 1)
            
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 1)
    }
    
    func testEthereumMiddlewareTransactionsSuccesResult() {
        let expect = expectation(description: "Succes request")
        
        let modelString = "{\"jsonrpc\":\"2.0\",\"id\":0, \"result\": [\(transaction)]}"
        let data = Data(modelString.utf8)
        let networkManager = FakeSuccessNetworkManager(model: data)
        ethereumMiddlware = EthereumMiddleware(networkManager: networkManager)
        ethereumMiddlware?.getTransactionInBlockRange(from: 1, to: 1, transactions: { (transactions) in
            
            XCTAssertEqual(transactions.count , 1)
            
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 1)
    }
}

fileprivate var transaction = "{\"type\":\"mined\",\"blockHash\":\"0x757012412be5a620d0a5c02c90b5b2dd55b31645e5d4f3787da40883f2c1ff46\",\"transactionHash\":\"0x69f2d4d58d2617364de5e4226529d1a665c38b13595d403408865c32fb209e2c\",\"transactionIndex\":\"0x0\",\"topics\":[\"0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef\",\"0x00000000000000000000000052629bf05f4d2ca4523ebaa0c4c2f36e20566897\",\"0x0000000000000000000000000930b0e6ef3e5d2d3e2b7343091937f8202c3f1d\"],\"blockNumber\":\"0x70852b\",\"address\":\"0x2d184014b5658c453443aa87c8e9c4d57285620b\",\"transactionLogIndex\":\"0x0\",\"logIndex\":\"0x0\",\"removed\":false,\"data\":\"0x00000000000000000000000000000000000000000000006605ff24bc95280000\"}"
