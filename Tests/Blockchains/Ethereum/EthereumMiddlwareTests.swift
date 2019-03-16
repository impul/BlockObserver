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
    
    func testEthereumMiddleWareSuccesResult() {
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
}
