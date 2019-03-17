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
        
        let modelString = "{\"jsonrpc\":\"2.0\",\"id\":0, \"result\": { \"transactions\": [\(transaction)] }}"
        let data = Data(modelString.utf8)
        let networkManager = FakeSuccessNetworkManager(model: data)
        ethereumMiddlware = EthereumMiddleware(networkManager: networkManager)
        ethereumMiddlware?.getTransactionsInBlock(block: 1, transactions: { (transactions) in
            
            XCTAssertEqual(transactions.count , 1)
            
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 1)
    }
}

fileprivate var transaction = "{\"nonce\": \"0x12e31a\",\"from\": \"0x564286362092d8e7936f0549571a803b203aaced\",\"chainId\": \"0x1\",\"hash\": \"0x1bfad35a5a18cd77049855217190fbd038ef400784e7d4a88db6c36951f3c380\",\"blockHash\": \"0x951c968ca30fda890fd6b7c9f5eb523f31019c55dd7f2a52f1455a5355b3c0ad\",\"publicKey\": \"0x57a5263fde1a9af0897f91f89b195cd4b930bcbf01f607fb606d32a005813542cf61cd878e38e57bb1e57a0f6730c0711c4c75dca634a4242b680374b08f8c99\",\"standardV\": \"0x1\",\"gas\": \"0x19518\",\"value\": \"0x0\",\"blockNumber\": \"0x70a842\",\"to\": \"0x0d8775f648430679a709e98d2b0cb6250d2887ef\",\"s\": \"0x47e20ce96d97c4161272632c089c3d5939326fb5fa5543694ad8da8a78654a0d\",\"r\": \"0x34a0ea838fafe0ac2979cfa289c1578221fbf0d695f76465e82875024a7daad5\",\"v\": \"0x26\",\"input\": \"0xa9059cbb00000000000000000000000047449cea2b5da961e1ced7e7360529155f3493e700000000000000000000000000000000000000000000000ff011d2523cd80000\",\"transactionIndex\": \"0x0\",\"gasPrice\": \"0x9502f9000\"}"
